import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:window_manager/window_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/anime.dart';
import '../../data/repositories/anime_repository.dart';
import '../../data/services/aniskip_service.dart';
import '../../providers/repositories_provider.dart';
import 'player_state.dart';
import '../../core/logger.dart'; 
import '../library_provider.dart';
import '../../data/services/discord_service.dart';

final playerProvider = StateNotifierProvider.autoDispose<PlayerNotifier, AppPlayerState>((ref) {
  final repo = ref.watch(animeRepoProvider);
  // Используем watch, но так как экземпляр SharedPreferences обычно не меняется,
  // это безопасно и соответствует правилам Riverpod.
  final prefs = ref.watch(sharedPrefsProvider);
  return PlayerNotifier(repo, prefs);
});

class PlayerNotifier extends StateNotifier<AppPlayerState> {
  final SharedPreferences _prefs;
  final AnimeRepository _repository;
  final Player player = Player();
  final List<StreamSubscription> _subscriptions =[];
  final DiscordService _discordService = DiscordService(); 
  Timer? _uiTimer;
  Timer? _nextEpTimer;

  // --- Новые флаги для оптимизации ---
  int _lastSavedSeconds = -1; 
  int _lastStateSeconds = -1; // Для троттлинга обновления UI
  bool _isEpisodeMarkedWatched = false; // Защита от спама в БД на 90%
  bool _isLoading = false; // Защита от двойного нажатия "Следующая серия"

  bool _wasFullScreen = false;
  bool _wasMaximized = false;
  Size _previousSize = const Size(1280, 720);
  Offset _previousPosition = Offset.zero;
  double _lastVolume = 100.0;

  PlayerNotifier(this._repository, this._prefs) : 
    super(AppPlayerState(volume: _prefs.getDouble('player_volume') ?? 100.0)) {
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    final playerSettings = _prefs;
    final savedVolume = playerSettings.getDouble('player_volume') ?? 100.0;
    
    player.setVolume(savedVolume);

    final dynamic engine = player.platform;
    
    // Оптимизация субтитров
    engine.setProperty('sub-ass', 'yes');
    engine.setProperty('sub-ass-override', 'scale'); 
    engine.setProperty('sub-pos', '90'); 
    
    // Языки
    final alang = playerSettings.getString('pref_alang') ?? 'jpn,jp,eng,en,rus,ru';
    final slang = playerSettings.getString('pref_slang') ?? 'rus,ru,eng,en';
    engine.setProperty('alang', alang);
    engine.setProperty('slang', slang);


    engine.setProperty('cache', 'yes');
    engine.setProperty('cache-on-disk', 'no'); 

    engine.setProperty('demuxer-max-bytes', '150M');
    _subscriptions.add(player.stream.position.listen((pos) {
      final currentSeconds = pos.inSeconds;
      SkipInterval? currentActiveSkip;
      final currentPosInDouble = pos.inMilliseconds / 1000.0;

      for (var skip in state.skipIntervals) {
        if (currentPosInDouble >= skip.startTime && currentPosInDouble <= skip.endTime) {
          currentActiveSkip = skip;
          break;
        }
      }

      if(state.activeSkip != currentActiveSkip) {
        talker.debug('AniSkip UI Триггер: Кнопка изменилась на -> ${currentActiveSkip?.type ?? "Скрыта"}');
        state = state.copyWith(
          activeSkip: currentActiveSkip,
          clearActiveSkip: currentActiveSkip == null,
        );
      }

      if (currentSeconds != _lastStateSeconds) {
        _lastStateSeconds = currentSeconds;
        state = state.copyWith(position: pos);
      }

      if (currentSeconds > 0 && (currentSeconds - _lastSavedSeconds).abs() >= 15) {
        _lastSavedSeconds = currentSeconds;
        _savePositionToDb();
      }
      
      if (state.duration.inSeconds > 0) {
        final progress = currentSeconds / state.duration.inSeconds;
        if (progress >= 0.9 && !_isEpisodeMarkedWatched && state.animeId != null && state.videoPath != null) {
          _isEpisodeMarkedWatched = true;
          _repository.markEpisodeAsWatched(state.animeId!, state.videoPath!);
          talker.info("Episode marked as watched: ${state.videoPath}");
        } 
      }
    }));

    _subscriptions.add(player.stream.duration.listen((dur) {
      state = state.copyWith(duration: dur);
    }));

    _subscriptions.add(player.stream.playing.listen((playing) {
      state = state.copyWith(isPlaying: playing);
      if (playing) {
        _startUiHider();
      } else {
        _savePositionToDb();
      }
    }));

    _subscriptions.add(player.stream.volume.listen((vol) {
      state = state.copyWith(volume: vol);
    }));

    _subscriptions.add(player.stream.tracks.listen((tracks){
      state = state.copyWith(
        audioTracks: tracks.audio,
        subtitleTracks: tracks.subtitle,
      );
    }));

    _subscriptions.add(player.stream.track.listen((track) {
      state = state.copyWith(
        currentAudio: track.audio,
        currentSubtitle: track.subtitle,
      );
    }));

    _subscriptions.add(player.stream.completed.listen((completed) {
      if (completed && hasNextEpisode) {
        state = state.copyWith(isVideoCompleted: true);

        _nextEpTimer?.cancel();
        _nextEpTimer = Timer(const Duration(seconds: 5), () {
          if (mounted && state.isVideoCompleted) {
            playNext();
          }
        });
      }
    }));

      _subscriptions.add(player.stream.log.listen((event) {
      final msg = '[MPV ${event.prefix}] ${event.text}';
      if (event.level == 'fatal' || event.level == 'error') {
        talker.error(msg);
      } else if (event.level == 'warn') {
        talker.warning(msg);
      } else if (event.level == 'info') {
        talker.info(msg);
      } else {
        // Выводим debug/trace логи
        talker.debug(msg);
      }
    }));
  }

  void setVolume(double value) {
    player.setVolume(value);
    _prefs.setDouble('player_volume', value);
    showUi();
  }

  void changeVolume(double delta) {
    double newVolume = (state.volume + delta).clamp(0.0, 100.0);
    setVolume(newVolume);
  }

  void toggleMute() {
    if (state.volume > 0) {
      _lastVolume = state.volume; // Запоминаем текущую громкость
      setVolume(0.0);
    } else {
      // Возвращаем старую громкость (или 100, если вдруг она была 0)
      setVolume(_lastVolume > 0 ? _lastVolume : 100.0);
    }
  }

  void cancelAutoPlay() {
    _nextEpTimer?.cancel();
    state = state.copyWith(isVideoCompleted: false);
  }

  bool get hasNextEpisode {
    final currentIndex = state.playlist.indexOf(state.videoPath ?? '');
    return currentIndex != -1 && currentIndex + 1 < state.playlist.length;
  }

  Future<void> playNext() async {
    if (!hasNextEpisode || state.animeId == null) return;

    final currentIndex = state.playlist.indexOf(state.videoPath!);
    final nextPath = state.playlist[currentIndex + 1];

    await loadVideo(state.animeId!, nextPath);
  }

  Future<void> loadVideo(int animeId, String path) async {
    if (_isLoading){
       talker.warning("loadVideo: Блокировка (уже идет загрузка)");
       return;
    }
    _isLoading = true;

    try {
       talker.info("loadVideo: СТАРТ ЗАГРУЗКИ: $path");
      _nextEpTimer?.cancel();
      if (!File(path).existsSync()) {
        talker.error("loadVideo: Файл не найден!");
        return;
      }

      final subsMap = await _applyExternalMedia(path);
      final anime = await _repository.getAnimeById(animeId);
      final entry = anime?.playbackPositions.where((e) => e.path == path).firstOrNull;
      int savedSeconds = entry?.position ?? 0;
      List<SkipInterval> skips = [];

       if (anime != null) {
        final existingData = anime.skipData.where((e) => e.episodePath == path).firstOrNull;

        if (existingData != null) {
          skips = existingData.intervals.map((i) => SkipInterval(
            type: i.type ?? 'op', 
            startTime: i.startTime ?? 0.0, 
            endTime: i.endTime ?? 0.0
          )).toList();
          talker.info('AniSkip: Таймкоды загружены из локальной БД (мгновенно)');
        } 
        else {
          // Если нет в БД, проверяем, есть ли ID
          if (anime.shikimoriId == null) {
            talker.warning('AniSkip: Пропуск невозможен. shikimoriId = null (Нажмите "Обновить данные из сети" на постере)');
          } else {
            // Вытаскиваем только имя файла
            final fileName = path.split(Platform.pathSeparator).last;
            
            // Умная регулярка: ищет "[01]", "- 01", "Ep 01"
            int? epNumber;
            final regex = RegExp(r'(?:\s|-|\[|[Ee]p\s*)(\d{1,4})(?:v\d+)?(?:\s|-|\]|\.)');
            for (final match in regex.allMatches(fileName)) {
              final val = int.tryParse(match.group(1)!);
              // Игнорируем разрешения видео (1080, 720, 480) и года (2023)
              if (val != null && val != 1080 && val != 720 && val != 480 && val < 2000) {
                epNumber = val;
                break;
              }
            }

            // Запасной план: ищем последние цифры перед .mkv (для формата "Наруто 01.mkv")
            if (epNumber == null) {
              final fallback = RegExp(r'(\d+)(?:v\d+)?\.\w+$').firstMatch(fileName);
              if (fallback != null) epNumber = int.tryParse(fallback.group(1)!);
            }

            // Проверяем, смогли ли найти номер
            if (epNumber != null) {
              talker.info('AniSkip: В БД пусто. Ищем таймкоды для серии $epNumber (MAL ID: ${anime.shikimoriId}) в сети...');
              skips = await AniSkipService().getSkipTimes(anime.shikimoriId!, epNumber);
              
              if (skips.isNotEmpty) {
                final newSkipDb = EpisodeSkipData()
                  ..episodePath = path
                  ..intervals = skips.map((s) => SkipIntervalDb()
                    ..type = s.type
                    ..startTime = s.startTime
                    ..endTime = s.endTime
                  ).toList();

                anime.skipData = [...anime.skipData, newSkipDb];
                await _repository.saveAnime(anime); 
                talker.info('AniSkip: Таймкоды успешно сохранены в БД!');
                
              } else {
                talker.info('AniSkip: Сервер не нашел таймкодов для этой серии (или их еще никто не добавил).');
              }
            } else {
              talker.warning('AniSkip: Не удалось распознать номер серии из файла: $fileName');
            }
            for (var s in skips) {
                talker.info('🎯 AniSkip: ${s.type} с ${s.startTime.toInt()} по ${s.endTime.toInt()} секунду');
            }
          }
        }
      }

      talker.info("ЗАГРУЖАЕМ ВИДЕО: Сохраненная позиция = $savedSeconds сек.");

      // Сбрасываем флаги для нового видео
      _isEpisodeMarkedWatched = false;
      _lastSavedSeconds = savedSeconds;
      _lastStateSeconds = -1;

      state = state.copyWith(
        animeId: animeId,
        videoPath: path,
        windowTitle: anime?.title,
        isPlaying: false,
        position: Duration.zero,
        isVideoCompleted: false,
        externalSubsMap: subsMap, 
        playlist: anime?.sortedEpisodes ?? [],
        skipIntervals: skips,
        activeSkip: null, 
        clearActiveSkip: true,
      );

      
      await player.open(Media(path), play: true); // Сразу запускаем
      if (savedSeconds > 0) {
        await player.stream.duration.firstWhere((d) => d.inMilliseconds > 0);
        await player.seek(Duration(seconds: savedSeconds));
      }

      await player.play();  
      _startUiHider();
       _discordService.updatePresence(
        title: anime?.title ?? 'Аниме',
        episode: 'Смотрит', 
        currentPositionSeconds: savedSeconds,
        durationSeconds: state.duration.inSeconds > 0 ? state.duration.inSeconds : null,
        isPlaying: true,
       );
    } finally {
      // Обязательно снимаем блокировку
      _isLoading = false;
    }
  }

  Future<Map<String, List<String>>> _applyExternalMedia(String videoPath) async {
    Map<String, List<String>> subsMap = {};
    try {
      final parentDir = File(videoPath).parent;
      Set<String> audioDirs = {};
      Set<String> subDirs = {};
      String? fontsDir;

      await for (var entity in parentDir.list(recursive: true, followLinks: false)) {
        final path = entity.path;
        final pathLower = path.toLowerCase();

        if (entity is File) {
          if (pathLower.endsWith('.mka') || pathLower.endsWith('.m4a') ||
              pathLower.endsWith('.ac3') || pathLower.endsWith('.flac')) {
              audioDirs.add(entity.parent.path);

          } else if (pathLower.endsWith('.ass') || pathLower.endsWith('.srt')) {
            subDirs.add(entity.parent.path);

            final parts = entity.parent.path.replaceAll('\\', '/').split('/');
            String folderName = parts.last;
            if (parts.length > 1 && (folderName.toLowerCase() == 'надписи' || folderName.toLowerCase() == 'signs')) {
              folderName = "${parts[parts.length - 2]} $folderName";
            }

            final fileName = entity.uri.pathSegments.last;
            subsMap.putIfAbsent(fileName, () =>[]).add(folderName);
          }

        } else if (entity is Directory) {
          if (pathLower.endsWith('fonts') || pathLower.endsWith('шрифты')) {
            fontsDir = path;
          }
        }
      }

      final dynamic engine = player.platform;
      engine.setProperty('sub-auto', 'fuzzy');
      engine.setProperty('audio-file-auto', 'fuzzy');
      String sep = Platform.isWindows ? ';' : ':';

      final sortedAudioDirs = audioDirs.toList()..sort();
      final sortedSubDirs = subDirs.toList()..sort();

      if (sortedAudioDirs.isNotEmpty) engine.setProperty('audio-file-paths', sortedAudioDirs.join(sep));
      if (sortedSubDirs.isNotEmpty) engine.setProperty('sub-file-paths', sortedSubDirs.join(sep));
      if (fontsDir != null) engine.setProperty('sub-fonts-dir', fontsDir);

    } catch (e, st) {
      talker.handle(e, st, "Ошибка автопоиска видео");
    }

    return subsMap;
  }

  // Управление
  void togglePlay() {
    player.playOrPause();
    _savePositionToDb();
    _startUiHider();

    final isGoingToPlay = !state.isPlaying; 

    String epString = "Смотрит";
    if (state.videoPath != null) {
      final epIndex = state.playlist.indexOf(state.videoPath!) + 1;
      if (epIndex > 0) epString = "Эпизод $epIndex";
    }

    _discordService.updatePresence(
      title: state.windowTitle ?? 'Аниме',
      episode: isGoingToPlay ? epString : "На паузе",
      currentPositionSeconds: state.position.inSeconds,
      durationSeconds: state.duration.inSeconds,  
      isPlaying: isGoingToPlay,
    );
  } 

  void seek(Duration position) => player.seek(position);

  void toggleUi() {
    state = state.copyWith(isUiVisible: !state.isUiVisible);
    
    final dynamic engine = player.platform;
    engine.setProperty('sub-pos', state.isUiVisible ? '88' : '100'); 
    
    if (state.isUiVisible) _startUiHider();
  }

  void showUi() {
    if (!state.isUiVisible) {
      state = state.copyWith(isUiVisible: true);
    }
    _startUiHider(); 
  }

  void _startUiHider() {
    _uiTimer?.cancel();
    if (!state.isUiVisible) return;
    
    _uiTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && state.isPlaying && !state.isSidebarOpen) {
        state = state.copyWith(isUiVisible: false);
      }
    });
  }

  // Аудио дорожки
  void setAudioTrack(AudioTrack track) {
    player.setAudioTrack(track);
  }

  // Сабы
  void setSubtitleTrack(SubtitleTrack track) {
    player.setSubtitleTrack(track);
  }

  // Сохранение в бд
  Future<void> _savePositionToDb() async {
    if (state.animeId == null || state.videoPath == null) return;
    
    await _repository.savePlaybackPosition(
      state.animeId!, 
      state.videoPath!, 
      state.position.inSeconds
    );
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    _nextEpTimer?.cancel();
    _discordService.clearPresence(); 
    final finalSeconds = state.position.inSeconds;
    final finalPath = state.videoPath;
    final finalId = state.animeId;
    final duration = state.duration.inSeconds;

    // Сначала отменяем все подписки на события (чтобы плеер не пытался обновить UI)
    for (var sub in _subscriptions) {
      sub.cancel();
    }

    // Сохраняем позицию в базу
    if (finalId != null && finalPath != null && finalSeconds > 5) {
      if (duration > 0 && (duration - finalSeconds) < 5) {
        talker.info("ВЫХОД: Сбрасываем позицию для $finalPath");
        _repository.savePlaybackPosition(finalId, finalPath, 0);
      } else {
        talker.info("ВЫХОД: Сохраняем позицию $finalSeconds сек.");
        _repository.savePlaybackPosition(finalId, finalPath, finalSeconds);
      }
    }
    
    if (state.isPiP) {
      windowManager.setAlwaysOnTop(false);
      windowManager.setMinimumSize(const Size(800, 600));
      windowManager.setSize(_previousSize);
      windowManager.setPosition(_previousPosition);
    }

    final engineToDispose = player;
    Future.delayed(const Duration(milliseconds: 300), () {
      engineToDispose.dispose();
    });
    
    super.dispose();
  }

  void setPlaybackSpeed(double speed) {
    player.setRate(speed);
    state = state.copyWith(playbackSpeed: speed);
    talker.info('Playback speed set to ${speed}x');
    showUi();
  }

  // Перемотка
  void seekRelative(int seconds) {
    int newSeconds = state.position.inSeconds + seconds;
    if(newSeconds < 0 ) newSeconds = 0;
    if (state.duration.inSeconds > 0 && newSeconds > state.duration.inSeconds) {
      newSeconds = state.duration.inSeconds;
    }

    player.seek(Duration(seconds: newSeconds));
    showUi();
    talker.debug('Seek relative: $seconds sec. New pos: $newSeconds');
  }

  Future<void> toggleFullscreen() async {
    //[ИСПРАВЛЕНО 10]: windowManager работает только на десктопе. 
    // На Android/iOS это вызвало бы краш.
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final isFull = await windowManager.isFullScreen();
      await windowManager.setFullScreen(!isFull);
    }
  }

  void toggleSideBar() {
    state = state.copyWith(isSidebarOpen: !state.isSidebarOpen);
    if (state.isSidebarOpen) {
      showUi();
    } else {
      _startUiHider();
    }

  }

  Future<void> togglePiP() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      if (state.isPiP) {
        //Выход из Pip
        await windowManager.setAlwaysOnTop(false);
        //Запрещаем менять размер окна меньше дефолтного
        await windowManager.setMinimumSize(const Size(800, 600)); 

        if (_wasFullScreen) {
          await windowManager.setFullScreen(true);
        } else if (_wasMaximized) {
          await windowManager.maximize();
        } else {
          await windowManager.setSize(_previousSize);
          await windowManager.setPosition(_previousPosition);
        }
        state = state.copyWith(isPiP: false);
        talker.info('Выход из режима PiP');
      } else {
        //Вход в pip
        _wasFullScreen = await windowManager.isFullScreen();
        _wasMaximized = await windowManager.isMaximized();
        _previousSize = await windowManager.getSize();
        _previousPosition = await windowManager.getPosition();

        if (_wasFullScreen) {
          await windowManager.setFullScreen(false);
        }

        state = state.copyWith(isPiP: true); // Сначала обновляем UI, чтобы избежать краша RenderFlex
        await Future.delayed(const Duration(milliseconds: 50)); // Даем UI перестроиться

        await windowManager.setAlwaysOnTop(true);
        // Разрешаем юзеру растягивать окно PiP, но не меньше 320x180
        await windowManager.setMinimumSize(const Size(320, 180)); 
        await windowManager.setSize(const Size(400, 225));
        await windowManager.setAlignment(Alignment.bottomRight);
        
        talker.info('Вход в режим PiP');
      }
    }
  }
}