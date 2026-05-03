import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:flutter/services.dart';
import 'package:nekaido_pre/presentation/player/widgets/player_sidebar.dart';
import 'package:window_manager/window_manager.dart';
import '../../../providers/player/player_provider.dart';
import 'widgets/seek_ripple_overlay.dart';
import 'widgets/player_overlay.dart';
import '../player/widgets/intents.dart';
import '../player/widgets/pip_overlay.dart';
import '../../../providers/library_provider.dart';
import '../../core/logger.dart'; 
import 'dart:async';
import '../../../../providers/settings_provider.dart';


class PlayerScreen extends ConsumerStatefulWidget {
  final int animeId;
  final String videoPath;

  const PlayerScreen({super.key, required this.animeId, required this.videoPath});

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  late final VideoController _videoController;
  DateTime? _lastTap;
  late final AppLifecycleListener _lifecycleListener;
  final FocusNode _playerFocusNode = FocusNode();
  int _seekAccumulator = 0;
  Timer? _seekHideTimer;
  bool _showLeftRipple = false;
  bool _showRightRipple = false;
  
  @override
  void initState() {
    super.initState();
    talker.info('PlayerScreen: Initializing screen');
    final playerNotifier = ref.read(playerProvider.notifier);
    final prefs = ref.read(sharedPrefsProvider);
    
    final hwdecMode = prefs.getString('pref_hwdec') ?? 'auto-safe';
    final isHardwareDisabled = (hwdecMode == 'no');

    talker.debug('PlayerScreen: Create VideoController (hwdec: $hwdecMode, enableHardwareAcceleration: ${!isHardwareDisabled})');

    _videoController = VideoController(
      playerNotifier.player,
      configuration: VideoControllerConfiguration(
         hwdec: hwdecMode, 
         enableHardwareAcceleration: !isHardwareDisabled,
      )
    );

    (playerNotifier.player.platform as dynamic)?.setProperty('hwdec', hwdecMode);

    _lifecycleListener = AppLifecycleListener(
      onHide: () {
        talker.info('App minimized. Continuing playback in background');
      }
    );

    Future.microtask(() {
      talker.info('PlayerScreen: Invoke loadVideo');
      playerNotifier.loadVideo(widget.animeId, widget.videoPath);
    });
  }

  @override
  void dispose() {
    talker.info('PlayerScreen: Closing screen (dispose)');
    try {
      talker.info('PlayerScreen: VideoController destroyed successfully');
    } catch (e, st) {
      talker.handle(e, st, 'PlayerScreen: Error destroying VideoController');
    }
    super.dispose();
    _playerFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(playerProvider.notifier);
    final playerState = ref.watch(playerProvider);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const SingleActivator(LogicalKeyboardKey.space): const PlayPauseIntent(),
          const SingleActivator(LogicalKeyboardKey.keyF): const FullScreenIntent(),
          const SingleActivator(LogicalKeyboardKey.escape): const EscapeIntent(),
          const SingleActivator(LogicalKeyboardKey.arrowRight): const SeekIntent(5),
          const SingleActivator(LogicalKeyboardKey.arrowLeft): const SeekIntent(-5),
          const SingleActivator(LogicalKeyboardKey.arrowUp): const VolumeIntent(5.0),
          const SingleActivator(LogicalKeyboardKey.arrowDown): const VolumeIntent(-5.0),
          const SingleActivator(LogicalKeyboardKey.keyP): const PiPIntent(),
        }, 
        child: Actions(
          actions: <Type, Action<Intent>> {
            PlayPauseIntent: _PlayerShortcutAction<PlayPauseIntent>(_playerFocusNode,(_) => notifier.togglePlay()),
            
            FullScreenIntent: _PlayerShortcutAction<FullScreenIntent>(_playerFocusNode, (_) {
              notifier.toggleFullscreen();
              _playerFocusNode.requestFocus();
            }),

            PiPIntent: _PlayerShortcutAction<PiPIntent>(_playerFocusNode,(_) => notifier.togglePiP()),
            
            SeekIntent: _PlayerShortcutAction<SeekIntent>(_playerFocusNode,(intent) => notifier.seekRelative(intent.seconds)),
            VolumeIntent: _PlayerShortcutAction<VolumeIntent>(_playerFocusNode,(intent) => notifier.changeVolume(intent.delta)),
            
              EscapeIntent: CallbackAction<EscapeIntent>(
              onInvoke: (_) async {
                if (!_playerFocusNode.hasPrimaryFocus) {
                  _playerFocusNode.requestFocus();
                  return null; 
                }

                if (playerState.isSidebarOpen) {
                  notifier.toggleSideBar();
                  return null;
                }
                
                if (playerState.isPiP) {
                  notifier.togglePiP();
                  return null;
                }
                
                bool isFull = await windowManager.isFullScreen();
                if(isFull) {
                  await windowManager.setFullScreen(false);
                } else {
                  if(!context.mounted) return null;
                  Navigator.pop(context);
                }
                return null;
              },
            ),
          },
          child: Focus(
            focusNode: _playerFocusNode,
            autofocus: true,
            child: Stack(
              children:[
                // === СЛОЙ 1: ПЛЕЕР ===
                Positioned.fill(
                  child: MouseRegion(
                    cursor: playerState.isUiVisible ? SystemMouseCursors.basic : SystemMouseCursors.none,
                    onHover: (_) => notifier.showUi(),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if(!_playerFocusNode.hasPrimaryFocus) {
                          _playerFocusNode.requestFocus();
                        }

                        if(playerState.isSidebarOpen) {
                          notifier.toggleSideBar();
                          return;
                        }

                      },
                      onDoubleTapDown: (TapDownDetails details) {
                        final screenWidth = MediaQuery.of(context).size.width;
                        final tapX = details.globalPosition.dx;
                         _seekHideTimer?.cancel();

                        if (tapX < screenWidth * 0.3) {
                          notifier.seekRelative(-10);
                          setState(() {
                            _showRightRipple = false;
                            _showLeftRipple = true;
                            _seekAccumulator = _seekAccumulator > 0 ? - 10 : _seekAccumulator - 10;
                          });
                        }
                        else if (tapX > screenWidth * 0.7) {
                          notifier.seekRelative(10);
                          setState(() {
                            _showRightRipple = true;
                            _showLeftRipple = false;
                             _seekAccumulator = _seekAccumulator < 0 ? 10 : _seekAccumulator + 10;
                          });
                        }
                        else {
                          notifier.toggleFullscreen();
                          return;
                        }

                        _seekHideTimer = Timer(const Duration(milliseconds: 600), () {
                          if (mounted) {
                            setState(() {
                                _showLeftRipple = false;
                              _showRightRipple = false;
                            }); 
                            Future.delayed(const Duration(milliseconds: 200), () {
                              if (mounted && !_showLeftRipple && !_showRightRipple) {
                                 setState(() => _seekAccumulator = 0);
                              }
                            });
                          }
                        });
                      },
                      child: Stack(
                        children:[
                          Positioned.fill(
                            child: Container(
                              color: Colors.black,
                              child: Center(
                                child: Video(
                                  controller: _videoController,
                                  controls: NoVideoControls,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: SeekRippleOverlay(
                              isLeft: _showLeftRipple,
                              isRight: _showRightRipple,
                              seconds: _seekAccumulator,
                            ),
                          ),

                          if(playerState.isPiP) const PipOverlay() else const PlayerOverlay(),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: playerState.isVideoCompleted
                                ? _buildNextEpisodeScreen(ref, notifier)
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                if (!playerState.isPiP)
                  PlayerSidebar(playerFocusNode: _playerFocusNode), 
              ],
            ),
          ),
        ),
      ),
    );
  }
    Widget _buildNextEpisodeScreen(WidgetRef ref, dynamic notifier) {
    return Container(
      key: const ValueKey('NextEpisodeScreen'),
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Next episode starts in...",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: 120,
              height: 120,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 1.0, end: 0.0), 
                duration: const Duration(seconds: 5),
                curve: Curves.linear, 
                builder: (context, value, child) {
                  int secondsLeft = (value * 5).ceil();

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: value,
                        color: Color(ref.watch(settingsProvider).accentColorValue),
                        backgroundColor: Colors.white12,
                        strokeWidth: 8,
                      ),
                      Center(
                        child: Text(
                          "$secondsLeft",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => notifier.cancelAutoPlay(), 
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => notifier.playNext(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(ref.watch(settingsProvider).accentColorValue),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text("", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class _PlayerShortcutAction<T extends Intent> extends Action<T> {
  final FocusNode playerFocusNode;
  final void Function(T intent) onInvokeCallback;

  _PlayerShortcutAction(this.playerFocusNode, this.onInvokeCallback);

  @override
  bool isEnabled(T intent) {

    return playerFocusNode.hasPrimaryFocus;
  }

  @override
  Object? invoke(T intent) {
    onInvokeCallback(intent);
    return null;
  }
}