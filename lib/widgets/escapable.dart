import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Escapable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onEscape;

  const Escapable({super.key, required this.child, this.onEscape});

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): onEscape ?? () {
          if (context.mounted) {
            FocusManager.instance.primaryFocus?.unfocus(); 
            Navigator.maybePop(context);
          }
        },
      },
      child: Focus(
        autofocus: true,
        descendantsAreFocusable: true, 
        child: child,
      ),
    );
  }
}