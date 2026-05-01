import 'dart:io';
import 'package:flutter/foundation.dart'; 
import 'package:talker_flutter/talker_flutter.dart';
import 'package:path_provider/path_provider.dart';

final talker = Talker();

Future<void> initLogger() async {
  try {
    final dir = await getApplicationDocumentsDirectory();

    final logsDir = Directory('${dir.path}/NekaidoLogs');
    if (!logsDir.existsSync()) {
      logsDir.createSync(recursive: true);
    }

    _cleanupOldLogs(logsDir);

    final now = DateTime.now();
    final timestamp = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}';
    final logFile = File('${logsDir.path}/log_$timestamp.txt');

    talker.configure(
      logger: TalkerLogger(
        settings: TalkerLoggerSettings( // 
          enableColors: true, 
        ),
      )
    );

    talker.stream.listen((TalkerData data) {
      final time = DateTime.now().toString().split('.').first; 
      
      final level = data.logLevel?.name.toUpperCase() ?? 'INFO'; 
      
      final msg = data.message ?? '';
      final exception = data.exception != null ? '\nException: ${data.exception}' : '';
      final stack = data.stackTrace != null ? '\nStackTrace: ${data.stackTrace}' : '';
      
      final cleanLog = '[$time] [$level] $msg$exception$stack\n';
      
      logFile.writeAsString(cleanLog, mode: FileMode.append).catchError((e) {
        debugPrint('Error writing log to file: $e'); 
        return logFile; 
      });
    });

    talker.info('Logger initialized. New session: $timestamp');
  } catch (e) {
    debugPrint('Error creating log file: $e'); 
  }
}

void _cleanupOldLogs(Directory logsDir) {
  try {
    final files = logsDir.listSync().whereType<File>().toList();
    if (files.length > 10) {
      files.sort((a,b) => a.lastModifiedSync().compareTo(b.lastModifiedSync()));

      final toDelete = files.length - 10;

      for (int i = 0; i < toDelete; i++) {
        files[i].deleteSync();
        debugPrint('Deleted old log: ${files[i].path}'); 
      }
    }
  } catch (e) {
    debugPrint('Error cleaning up old logs: $e'); 
  }
}