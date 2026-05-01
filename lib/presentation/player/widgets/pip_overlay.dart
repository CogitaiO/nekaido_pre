import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import '../../../../providers/player/player_provider.dart';

class PipOverlay extends ConsumerWidget{
  const PipOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(playerProvider.select((s) => s.isUiVisible));
    final isPlaying = ref.watch(playerProvider.select((s) => s.isPlaying));
    final volume = ref.watch(playerProvider.select((s) => s.volume));
    final notifier = ref.read(playerProvider.notifier);

    return IgnorePointer(
      ignoring: !isVisible,
      child: AnimatedOpacity (
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          color: Colors.black54,
          child: Stack(
            children: [
              Positioned.fill(
                child: DragToMoveArea(
                  child: GestureDetector(
                    onDoubleTap: () => notifier.togglePiP(),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),

              Center(
                child: IconButton(
                  iconSize: 48,
                  icon: Icon(
                    isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    color: Colors.white,
                  ),
                  onPressed: () => notifier.togglePlay(),
                ),
              ),

              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 20,
                      icon: Icon(
                        volume == 0 ? Icons.volume_off : (volume < 50 ? Icons.volume_down : Icons.volume_up),
                        color: Colors.white,
                      ),
                      onPressed: () => notifier.toggleMute(),
                    ),

                    IconButton(
                      iconSize: 20,
                      tooltip: "Вернуться",
                      icon: const Icon(Icons.open_in_new, color: Colors.white),
                      onPressed: () => notifier.togglePiP(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}