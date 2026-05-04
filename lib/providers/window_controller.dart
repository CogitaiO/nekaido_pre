import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import '../core/logger.dart';

class WindowState {
  final bool isPiP;
  final bool isFullScreen;

  const WindowState({
    this.isPiP = false,
    this.isFullScreen = false,
  });

  WindowState copyWith({bool? isPiP, bool? isFullScreen}) {
    return WindowState(
      isPiP: isPiP ?? this.isPiP,
      isFullScreen: isFullScreen ?? this.isFullScreen,
    );
  }
}

class WindowController extends Notifier<WindowState>{
  Size _previousSize = const Size(1280, 720);
  Offset _previousPosition = Offset.zero;
  bool _wasFullScreen = false;
  bool _wasMaximized = false;

  @override
  WindowState build () => const WindowState();

  Future<void> toggleFullScreen() async {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final isFull = await windowManager.isFullScreen();
      await windowManager.setFullScreen(!isFull);
      state = state.copyWith(isFullScreen: !isFull);
    }
  }

  Future<void> togglePiP() async {
    if (!Platform.isWindows && !Platform.isLinux && !Platform.isMacOS) return;

    if (state.isPiP) {
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setMinimumSize(const Size(800, 600));

      if (_wasFullScreen) {
        await windowManager.setFullScreen(true);
      } else if (_wasMaximized) {
        await windowManager.maximize();
      } else {
        await windowManager.setSize(_previousSize);
        await windowManager.setPosition(_previousPosition);
      }
      
      state = state.copyWith(isPiP: false);
      talker.info('Exited PiP mode');
    } else {
      // Вход в PiP
      _wasFullScreen = await windowManager.isFullScreen();
      _wasMaximized = await windowManager.isMaximized();
      _previousSize = await windowManager.getSize();
      _previousPosition = await windowManager.getPosition();

      if (_wasFullScreen) {
        await windowManager.setFullScreen(false);
      }

      state = state.copyWith(isPiP: true);
      await Future.delayed(const Duration(milliseconds: 50)); // Фикс UI jank

      await windowManager.setAlwaysOnTop(true);
      await windowManager.setMinimumSize(const Size(320, 180));
      await windowManager.setSize(const Size(400, 225));
      await windowManager.setAlignment(Alignment.bottomRight);
      
      talker.info('Entered PiP mode');
    }
  }

  Future<void> exitPlayerCleanup() async {
    if (state.isPiP) {
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setMinimumSize(const Size(800, 600));
      await windowManager.setSize(_previousSize);
      await windowManager.setPosition(_previousPosition);
      state = state.copyWith(isPiP: false);
    }
  }
}

final windowControllerProvider = NotifierProvider<WindowController, WindowState>(WindowController.new);