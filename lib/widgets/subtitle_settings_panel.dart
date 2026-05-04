import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../providers/player/player_provider.dart';

class SubtitleSettingsPanel extends ConsumerStatefulWidget {
  final bool isInPlayer; 
  const SubtitleSettingsPanel({super.key, this.isInPlayer = false});

  @override
  ConsumerState<SubtitleSettingsPanel> createState() => _SubtitleSettingsPanelState();
}

class _SubtitleSettingsPanelState extends ConsumerState<SubtitleSettingsPanel> {
  double? _tempSize;
  double? _tempOutline;
  double? _tempOpacity;

  void _updatePlayer() {
    if (widget.isInPlayer) {
      ref.read(playerProvider.notifier).applySubtitleSettings();
    }
  }

  @override
  Widget build (BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final primaryColor = Theme.of(context).colorScheme.primary;

    final currentSize = _tempSize ?? settings.subSize;
    final currentOutline = _tempOutline ?? settings.subOutlineSize;

    final backColor = Color(settings.subBackColorValue);
    final currentOpacity = _tempOpacity ?? backColor.a;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _FormatToggle(
                      title: "ASS", 
                      isActive: !settings.overrideAssStyles, 
                      onTap: () {
                        notifier.updateSubSettings(overrideAssStyles: false);
                         _updatePlayer();
                      }
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _FormatToggle(
                      title: "Custom", 
                      isActive: settings.overrideAssStyles, 
                      onTap: () {
                        notifier.updateSubSettings(overrideAssStyles: true);
                        _updatePlayer();
                      }
                    )
                  ),
                ],
              ),
              if (!settings.overrideAssStyles)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Theme.of(context).colorScheme.error),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "When 'ASS' is selected, the settings below are ignored (dubbing studio styles are applied)",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 24),

        Opacity(
           opacity: !settings.overrideAssStyles ? 0.3 : 1.0,
           child: AbsorbPointer(
            absorbing: !settings.overrideAssStyles,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Text Color", style: TextStyle(color: Colors.white)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ColorDot(color: Colors.white, isSelected: settings.subColorValue == Colors.white.toARGB32(),
                      onTap: () {notifier.updateSubSettings(subColorValue: Colors.white.toARGB32()); _updatePlayer(); }),
                      _ColorDot(color: Colors.yellowAccent, isSelected: settings.subColorValue == Colors.yellowAccent.toARGB32(),
                      onTap: () {notifier.updateSubSettings(subColorValue: Colors.yellowAccent.toARGB32()); _updatePlayer(); }),
                       _ColorDot(color: Colors.lightGreen, isSelected: settings.subColorValue == Colors.lightGreen.toARGB32(),
                      onTap: () {notifier.updateSubSettings(subColorValue: Colors.lightGreen.toARGB32()); _updatePlayer(); }),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                _buildSliderRow(
                  label: "Background dimming",
                  value: currentOpacity,
                  min: 0.0, max: 1.0,
                  primaryColor: primaryColor,
                  onChanged: (val) => setState(() => _tempOpacity = val),
                  onChangeEnd: (val) {
                     final newColor = Colors.black.withValues(alpha: val);
                    notifier.updateSubSettings(subBackColorValue: newColor.toARGB32());
                    _tempOpacity = null;
                    _updatePlayer();
                  }
                ),
              ],
            ),
           ),
        ),
      ],
    ); 
  }

  Widget _buildSliderRow ({
    required String label, required double value, 
    required double min, required double max, 
    required Color primaryColor,
    required Function(double) onChanged, required Function(double) onChangeEnd
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: primaryColor,
                  thumbColor: primaryColor,
                  inactiveTrackColor: Colors.white12,
                ), 
                child: Slider(
                  value: value, min: min, max: max,
                  onChanged: onChanged,
                  onChangeEnd: onChangeEnd,
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                value < 10 ? value.toStringAsFixed(1) : value.toInt().toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    );
  }

}

class _FormatToggle extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _FormatToggle({required this.title, required this.isActive, required this.onTap});  

  @override
  Widget build (BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child:  AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isActive ? primaryColor : Colors.white12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? primaryColor : Colors.white54, 
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal
          ),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorDot({required this.color, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 12),
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? primaryColor : Colors.transparent, width: 3),
        ),
      ),
    );
  }
}