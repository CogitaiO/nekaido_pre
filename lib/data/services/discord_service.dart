import 'dart:io';
import 'package:discord_rpc/discord_rpc.dart';
import '../../core/logger.dart';

class DiscordService {
  // Вставь сюда свой Application ID из Discord Developer Portal
  static const String _clientId = '1499787664402939954'; 
  DiscordRPC? _rpc;
  bool _isInitialized = false;

  DiscordService() {
    _init();
  }

  void _init() {
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) return;

    try {
      _rpc = DiscordRPC(applicationId: _clientId);
      _rpc!.start(autoRegister: true);
      _isInitialized = true;
      talker.info('DiscordService: RPC Initialized');
    } catch (e) {
      // Игнорируем ошибку (вероятно, Discord просто закрыт или не установлен)
      talker.debug('DiscordService: Failed to initialize. Error: $e');
      _isInitialized = false;
    }
  }

  void updatePresence({
    required String title,
    required String episode,
    int? currentPositionSeconds,
    int? durationSeconds,
    bool isPlaying = true,
  }) {
    if (!_isInitialized || _rpc == null) return;

    try {
      // Формируем красивый таймер
      int? endTimestamp;

      if (isPlaying && currentPositionSeconds != null && durationSeconds != null && durationSeconds > 0) {
        // Подсчитываем, когда закончится серия в реальном времени
        final now = DateTime.now().millisecondsSinceEpoch;
        final leftSeconds = durationSeconds - currentPositionSeconds;
        endTimestamp = now + (leftSeconds * 1000); 
      }

      _rpc!.updatePresence(
        DiscordPresence(
          state: episode, 
          details: title, 
          largeImageKey: 'logo', 
          largeImageText: 'Nekaido', 
          smallImageKey: isPlaying ? 'play' : 'pause', 
          smallImageText: isPlaying ? 'Смотрит' : 'На паузе', 
          endTimeStamp: endTimestamp, 
        ),
      );
    } catch (e) {
      talker.warning('DiscordService: Error updating presence: $e');
    }
  }

  void clearPresence() {
    if (!_isInitialized || _rpc == null) return;
    try {
      _rpc!.clearPresence();
    } catch (e) {
      talker.debug('DiscordService: Error clearing presence: $e');
    }
  }

  void dispose() {
    clearPresence();
    _rpc?.shutDown();
  }
}