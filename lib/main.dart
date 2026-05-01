import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:window_manager/window_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:discord_rpc/discord_rpc.dart';
import 'dart:io';
import 'core/logger.dart';
import 'domain/anime.dart';
import 'data/repositories/anime_repository.dart';
import 'providers/repositories_provider.dart';
import 'presentation/library_screen.dart';
import 'providers/library_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await windowManager.ensureInitialized();
  await initLogger(); 
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    try {
      DiscordRPC.initialize(); 
    } catch (e) {
      talker.debug('DiscordRPC initialization failed: $e');
    }
  }
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  try {
    final prefs = await SharedPreferences.getInstance();
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open([AnimeSchema], directory: dir.path);
    final repository = AnimeRepository(isar);

    FlutterError.onError = (details) {
      talker.handle(details.exception, details.stack, 'Critical UI error');
    };

    PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack, 'Unhandled asynchronous error');
    return true; // предотвращает полное падение приложения
  };

    runApp(
      ProviderScope(
        overrides: [
          animeRepoProvider.overrideWithValue(repository),
          sharedPrefsProvider.overrideWithValue(prefs),
        ],
        child: const MyApp(), // Запускаем MyApp
      ),
    );
  } catch (e, st) {
    talker.handle(e, st, 'Critical startup error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nekaido Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      // Указываем наш первый экран
      home: const LibraryScreen(), 
    );
  }
}

// А LibraryScreen перенеси в отдельный файл в папку presentation!


