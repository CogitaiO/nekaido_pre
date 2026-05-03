
import 'package:media_kit/media_kit.dart';
import '../../data/services/aniskip_service.dart';

class AppPlayerState {
  final int? animeId;
  final String? videoPath;
  final List<String> playlist;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final bool isFullscreen;
  final bool isUiVisible;
  final bool isVideoCompleted;
  final bool isPiP;
  final bool isSidebarOpen;
  final String? windowTitle;
  final double playbackSpeed;

  final List<AudioTrack> audioTracks;
  final List<SubtitleTrack> subtitleTracks;
  final AudioTrack? currentAudio;
  final SubtitleTrack? currentSubtitle;
  final Map<String, List<String>> externalSubsMap;
  final List<SkipInterval> skipIntervals;
  final SkipInterval? activeSkip;

  AppPlayerState({
  this.animeId,
  this.videoPath,
  this.playlist = const [],
  this.isPlaying = false,
  this.position = Duration.zero,
  this.duration = Duration.zero,
  this.volume = 100.0,
  this.isFullscreen = false,
  this.isUiVisible = true,
  this.isVideoCompleted = false,
  this.isPiP = false,
  this.isSidebarOpen = false,
  this.windowTitle,
  this.playbackSpeed = 1.0, 

  this.audioTracks = const [],
  this.subtitleTracks = const[],
  this.currentAudio,
  this.currentSubtitle,
  this.externalSubsMap = const {}, 
  this.skipIntervals = const[],
  this.activeSkip,
  });

    AppPlayerState copyWith({
    int? animeId,
    String? videoPath,
    List<String>? playlist,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    double? volume,
    bool? isFullscreen,
    bool? isUiVisible,
    bool? isVideoCompleted,
    bool? isPiP,
    bool? isSidebarOpen,
    String? windowTitle,
    double? playbackSpeed,

    List<AudioTrack>? audioTracks,
    List<SubtitleTrack>? subtitleTracks,
    AudioTrack? currentAudio,
    SubtitleTrack? currentSubtitle,
    Map<String, List<String>>? externalSubsMap,
    List<SkipInterval>? skipIntervals,
    SkipInterval? activeSkip,
    bool clearActiveSkip = false, 
  }) {
    return AppPlayerState(
      animeId: animeId ?? this.animeId,
      videoPath: videoPath ?? this.videoPath,
      playlist: playlist ?? this.playlist,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      volume: volume ?? this.volume,
      isFullscreen: isFullscreen ?? this.isFullscreen,
      isUiVisible: isUiVisible ?? this.isUiVisible,
      audioTracks: audioTracks ?? this.audioTracks,
      subtitleTracks: subtitleTracks ?? this.subtitleTracks,
      currentAudio: currentAudio ?? this.currentAudio,
      currentSubtitle: currentSubtitle ?? this.currentSubtitle,
      externalSubsMap: externalSubsMap ?? this.externalSubsMap,
      isVideoCompleted: isVideoCompleted ?? this.isVideoCompleted,
      isPiP: isPiP ?? this.isPiP,
      isSidebarOpen: isSidebarOpen ?? this.isSidebarOpen,
      skipIntervals: skipIntervals ?? this.skipIntervals,
      activeSkip: clearActiveSkip ? null : (activeSkip ?? this.activeSkip), 
      windowTitle: windowTitle ?? this.windowTitle,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
    );
  }
}