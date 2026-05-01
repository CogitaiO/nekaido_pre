import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekaido_pre/presentation/player/widgets/skip_interval_track_shape.dart';
import 'track_selector_dialog.dart';
import '../../../../providers/player/player_provider.dart';
import '../../../../domain/anime.dart';

class PlayerProgressBar extends ConsumerStatefulWidget {
  const PlayerProgressBar({super.key});
  @override
  ConsumerState<PlayerProgressBar> createState() => _PlayerProgressBarState();
}

class _PlayerProgressBarState extends ConsumerState<PlayerProgressBar> {
  bool _isDragging = false;
  double _dragValue = 0.0;
  bool _isHoveringBar = false; // Отслеживаем наведение на прогресс-бар

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(playerProvider.select((s) => s.position));
    final duration = ref.watch(playerProvider.select((s) => s.duration));
    final volume = ref.watch(playerProvider.select((s) => s.volume)); 
    final isPlaying = ref.watch(playerProvider.select((s) => s.isPlaying));
    final notifier = ref.read(playerProvider.notifier);
    final activeSkips = ref.watch(playerProvider.select((s) => s.skipIntervals));
    double maxDuration = duration.inSeconds.toDouble();
    double currentPosition = _isDragging ? _dragValue : position.inSeconds.toDouble();
    if (currentPosition > maxDuration) currentPosition = maxDuration;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        // === 1. УМНЫЙ ПРОГРЕСС-БАР (Edge-to-Edge) ===
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Небольшой отступ от краев
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHoveringBar = true),
            onExit: (_) => setState(() => _isHoveringBar = false),
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              height: 20, // Зона захвата мышки
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  // Магия: толщина меняется при наведении
                  trackHeight: _isHoveringBar || _isDragging ? 4.0 : 2.0, 
                  // Кружок пропадает, когда мышка уходит
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: _isHoveringBar || _isDragging ? 6.0 : 0.0,
                  ),
                  overlayShape: SliderComponentShape.noOverlay, // Убираем родную тень Material
                  activeTrackColor: Colors.redAccent,
                  inactiveTrackColor: Colors.white24,
                  thumbColor: Colors.redAccent,

                  trackShape: SkipIntervalTrackShape(
                    intervals: activeSkips.map((s) => SkipIntervalDb()
                    ..startTime = s.startTime
                    ..endTime = s.endTime).toList(),
                    durationInSeconds: maxDuration,
                    skipColor: Colors.white30.withValues(alpha: 0.8),
                  ),
                ),
                child: Slider(
                  value: maxDuration > 0 ? currentPosition : 0.0,
                  min: 0.0,
                  max: maxDuration > 0 ? maxDuration : 1.0,
                  onChangeStart: (val) {
                    setState(() { _isDragging = true; _dragValue = val; });
                  },
                  onChanged: (val) {
                    setState(() { _dragValue = val; });
                  },
                  onChangeEnd: (val) {
                    notifier.seek(Duration(seconds: val.toInt()));
                    setState(() { _isDragging = false; });
                  },
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // === 2. ПАНЕЛЬ КНОПОК ===
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children:[
              // ЛЕВАЯ ГРУППА: Плей, Некст, Громкость, Время
              IconButton(
                iconSize: 32,
                icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white),
                onPressed: () => notifier.togglePlay(),
              ),
              if (notifier.hasNextEpisode)
                IconButton(
                  iconSize: 28,
                  icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                  onPressed: () => notifier.playNext(),
                ),
              const SizedBox(width: 8),

              // Блок звука
              Row(
                mainAxisSize: MainAxisSize.min,
                children:[
                  IconButton(
                    iconSize: 24,
                    icon: Icon(
                      volume == 0 ? Icons.volume_off : (volume < 50 ? Icons.volume_down : Icons.volume_up),
                      color: Colors.white,
                    ),
                    onPressed: () => notifier.toggleMute(),
                  ),
                  SizedBox(
                    width: 80, // Компактный ползунок звука
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.0,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
                        overlayShape: SliderComponentShape.noOverlay,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white24,
                        thumbColor: Colors.white,
                      ),
                      child: Slider(
                        value: volume,
                        min: 0.0,
                        max: 100.0,
                        onChanged: (val) => notifier.setVolume(val),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              
              // Время: 12:04 / 24:00
              Text(
                '${_format(Duration(seconds: currentPosition.toInt()))} / ${_format(duration)}', 
                style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)
              ),

              const Spacer(),

              // ПРАВАЯ ГРУППА: Настройки, PiP, Fullscreen
              IconButton(
                icon: const Icon(Icons.subtitles_rounded, color: Colors.white),
                tooltip: "Озвучка и Субтитры",
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) => const TrackSelectorDialog(),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.picture_in_picture_alt_rounded, color: Colors.white),
                tooltip: "Картинка в картинке",
                onPressed: () => notifier.togglePiP(),
              ),
              IconButton(
                icon: const Icon(Icons.format_list_bulleted_rounded, color: Colors.white),
                tooltip: "Серии и заметки",
                onPressed: () => notifier.toggleSideBar(),
              ),
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.fullscreen_rounded, color: Colors.white),
                onPressed: () => notifier.toggleFullscreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _format(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));
    if (d.inHours > 0) return '${twoDigits(d.inHours)}:$minutes:$seconds';
    return '$minutes:$seconds';
  }
}