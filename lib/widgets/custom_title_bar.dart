import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatefulWidget {
  final Color backgroundColor;
  final Widget? leading; // Кастомная кнопка слева (например, Назад)
  final Widget? title;   // Кастомный текст/виджет по центру

  const CustomTitleBar({
    super.key,
    this.backgroundColor = const Color(0xFF151515),
    this.leading,
    this.title,
  });

  @override
  State<CustomTitleBar> createState() => _CustomTitleBarState();
}

class _CustomTitleBarState extends State<CustomTitleBar> with WindowListener {
  bool _isMaximized = false;
  bool _isFullScreen = false; // Отслеживаем Fullscreen отдельно
  bool _isPiP = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _updateState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> _updateState() async {
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) return;

    final isMaximized = await windowManager.isMaximized();
    final isFullScreen = await windowManager.isFullScreen();
    final isPiP = await windowManager.isAlwaysOnTop();

    if (mounted) {
      setState(() {
        _isMaximized = isMaximized;
        _isFullScreen = isFullScreen;
        _isPiP = isPiP;
      });
    }
  }

  @override
  void onWindowMaximize() => _updateState();
  @override
  void onWindowUnmaximize() => _updateState();
  @override
  void onWindowEnterFullScreen() => _updateState();
  @override
  void onWindowLeaveFullScreen() => _updateState();

  @override
  Widget build(BuildContext context) {
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) return const SizedBox.shrink();
    if (_isPiP) return const SizedBox.shrink(); // В PiP шапка не нужна вообще

    return Container(
      height: 40, // Сделали чуть выше для удобства хвата
      color: widget.backgroundColor,
      child: Row(
        children:[
          // === ЛЕВАЯ ЧАСТЬ (Логотип или кнопка Назад) ===
          if (widget.leading != null) 
            widget.leading!
          else ...[
            const SizedBox(width: 16),
            const Icon(Icons.movie_filter, color: Colors.redAccent, size: 18),
            const SizedBox(width: 8),
          ],

          // === ТЕКСТ / НАЗВАНИЕ ===
          if (widget.title != null)
            widget.title!
          else
            const Text(
              'Nekaido', 
              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),

          // === ЦЕНТР: Зона перетаскивания ===
          // Если мы в FullScreen, перетаскивать нечего, но зону оставляем пустой
          Expanded(
            child: _isFullScreen 
              ? const SizedBox.shrink() 
              : DragToMoveArea(
                  child: Container(color: Colors.transparent),
                ),
          ),

          // === ПРАВАЯ ЧАСТЬ: Кнопки ОС ===
          // В Fullscreen кнопки винды не нужны!
          if (!_isFullScreen && (Platform.isWindows || Platform.isLinux)) ...[
            _WindowButton(
              icon: Icons.minimize,
              onTap: () async => await windowManager.minimize(),
            ),
            _WindowButton(
              icon: _isMaximized ? Icons.filter_none : Icons.crop_square,
              iconSize: _isMaximized ? 12 : 14,
              onTap: () async {
                if (_isMaximized) {
                  await windowManager.unmaximize();
                } else {
                  await windowManager.maximize();
                }
              },
            ),
            _WindowButton(
              icon: Icons.close,
              hoverColor: const Color(0xFFE81123),
              onTap: () async => await windowManager.close(),
            ),
          ],
        ],
      ),
    );
  }
}

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color hoverColor;
  final double iconSize;

  const _WindowButton({
    required this.icon,
    required this.onTap,
    this.hoverColor = Colors.white24,
    this.iconSize = 16,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 46,
          height: double.infinity,
          color: _isHovered ? widget.hoverColor : Colors.transparent,
          child: Icon(
            widget.icon,
            color: _isHovered && widget.hoverColor != Colors.white24 ? Colors.white : Colors.white70,
            size: widget.iconSize,
          ),
        ),
      ),
    );
  }
}