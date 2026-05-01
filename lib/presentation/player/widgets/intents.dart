import 'package:flutter/widgets.dart';

class PlayPauseIntent extends Intent { const PlayPauseIntent(); }
class FullScreenIntent extends Intent {const FullScreenIntent(); }
class EscapeIntent extends Intent {const EscapeIntent(); }
class PiPIntent extends Intent { const PiPIntent(); }
class PanicIntent extends Intent {const PanicIntent(); }

class SeekIntent extends Intent {
  final int seconds;
  const SeekIntent(this.seconds);
}

class VolumeIntent extends Intent {
  final double delta;
  const VolumeIntent(this.delta);
}

