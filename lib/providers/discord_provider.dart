import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekaido_pre/providers/player/player_state.dart';
import '../data/services/discord_service.dart';
import 'player/player_provider.dart';
import 'settings_provider.dart';

final discordServiceProvider = Provider<DiscordService>((ref) {
  final service = DiscordService();
  ref.onDispose(() => service.dispose());
  return service;
});

final discordIntegrationProvider = Provider.autoDispose<void>((ref) {
  final isEnabled = ref.watch(settingsProvider.select((s) => s.discordRpcEnabled));
  if (!isEnabled) return;

  final discord = ref.watch(discordServiceProvider);

  ref.listen<AppPlayerState>(playerProvider, (previous, next) {
    if (next.videoPath == null) {
      discord.clearPresence();
      return;
    }

    String epString = "Watching";
    final epIndex = next.playlist.indexOf(next.videoPath!) + 1;
    if (epIndex > 0) epString = "Episode $epIndex";

    discord.updatePresence(
      title: next.windowTitle ?? 'Anime',
      episode: next.isPlaying ? epString : "Paused",
      currentPositionSeconds: next.position.inSeconds,
      durationSeconds: next.duration.inSeconds,
      isPlaying: next.isPlaying,
    );
  });

  ref.onDispose(() {
    discord.clearPresence();
  });
});