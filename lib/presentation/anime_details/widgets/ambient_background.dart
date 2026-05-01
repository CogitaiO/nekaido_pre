import 'dart:ui';
import 'package:flutter/material.dart';

class AmbientBackground extends StatelessWidget{
  final Color color;
  const AmbientBackground({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -200, left: -200,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            width: 800, height: 800,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.15),
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 200)],
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}