import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import '../../widgets/escapable.dart';
import '../../providers/settings_provider.dart';
import '../../providers/library_provider.dart';
import '../../providers/repositories_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(savedFoldersProvider);
    final accentColor = Colors.redAccent;

    return Escapable(
      child: Scaffold(
        backgroundColor: Color(0xFF0F0F0F),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Настройки", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            const Text("Плеер", style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children:[
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.white54),
                    title: const Text("Приоритет озвучки", style: TextStyle(color: Colors.white)),
                    subtitle: const Text("jpn (Оригинал) или rus (Дубляж)", style: TextStyle(color: Colors.white38)),
                    trailing: DropdownButton<String>(
                      dropdownColor: const Color(0xFF1A1A1A),
                      value: ref.watch(playerSettingsProvider).audioLanguage.startsWith('jpn') ? 'jpn' : 'rus',
                      items: const[
                        DropdownMenuItem(value: 'jpn', child: Text("Японская", style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'rus', child: Text("Русская", style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (val) {
                        if (val == 'jpn') ref.read(playerSettingsProvider.notifier).updateAudioLang('jpn,jp,rus,ru');
                        if (val == 'rus') ref.read(playerSettingsProvider.notifier).updateAudioLang('rus,ru,jpn,jp');
                      },
                    ),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  ListTile(
                    leading: const Icon(Icons.subtitles, color: Colors.white54),
                    title: const Text("Приоритет субтитров", style: TextStyle(color: Colors.white)),
                    trailing: DropdownButton<String>(
                      dropdownColor: const Color(0xFF1A1A1A),
                      value: ref.watch(playerSettingsProvider).subLanguage.startsWith('rus') ? 'rus' : 'eng',
                      items: const[
                        DropdownMenuItem(value: 'rus', child: Text("Русские", style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'eng', child: Text("Английские", style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (val) {
                        if (val == 'rus') ref.read(playerSettingsProvider.notifier).updateSubLang('rus,ru,eng,en');
                        if (val == 'eng') ref.read(playerSettingsProvider.notifier).updateSubLang('eng,en,rus,ru');
                      },
                    ),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  ListTile(
                    leading: const Icon(Icons.memory, color: Colors.white54),
                    title: const Text("Аппаратное ускорение (Видеокарта)", style: TextStyle(color: Colors.white)),
                    subtitle: const Text("Измените, если видео тормозит или черный экран", style: TextStyle(color: Colors.white38)),
                    trailing: DropdownButton<String>(
                      dropdownColor: const Color(0xFF1A1A1A),
                      value: ref.watch(playerSettingsProvider).hwdec,
                      items: const[
                        DropdownMenuItem(value: 'auto', child: Text("Автоматически (auto)", style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'auto-safe', child: Text("Безопасный (auto-safe)", style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'd3d11va', child: Text("Windows (d3d11va)", style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'no', child: Text("Отключено (Процессор)", style: TextStyle(color: Colors.redAccent))),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          ref.read(playerSettingsProvider.notifier).updateHwdec(val);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text("Библиотека", style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (folders.isEmpty) 
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(child: Text("Вы еще не добавили ни одной папки", style: TextStyle(color: Colors.white38))),
                    )
                  else
                    ...folders.map((folder) => ListTile(
                      leading: const Icon(Icons.folder, color: Colors.white54),
                      title: Text(folder, style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white38),
                        onPressed: () => ref.read(savedFoldersProvider.notifier).removeFolder(folder),
                        tooltip: "Удалить из сканирования",
                      ),
                    )),
                  const Divider(color: Colors.white12, height: 1),

                  //Кнопка добавления новой папки

                  InkWell(
                    onTap: () async {
                      final String? folderPath = await FilePicker.getDirectoryPath();
                      if (folderPath != null) {
                        ref.read(savedFoldersProvider.notifier).addFolder(folderPath);
                        ref.read(scannerProvider).scanAndGroupFiles(folderPath);
                        if(context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Папка добавлена в очередь на сканирование"), 
                                                                                    backgroundColor: Colors.lightGreen,));
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: accentColor),
                          const SizedBox(width: 8),
                          Text("Добавить папку", style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            //Кнопка пересканировать
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: folders.isEmpty ? null : () async {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Сканирование началось...")));
                final scanner = ref.read(scannerProvider);
                for (var folder in folders) {
                  await scanner.scanAndGroupFiles(folder);
                }
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Сканирование завершено!"), backgroundColor: Colors.lightGreen));
                }
              },
              icon: const Icon(Icons.sync_rounded),
              label: const Text("Пересканировать библиотеку"),
            ),

            const SizedBox(height: 48),

            const Text("Данные", style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: ListTile(
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                leading: const Icon(Icons.delete_forever),
                title: const Text("Очистить базу данных", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("Удалит все тайтлы, историю просмотра и заметки. Сами видеофайлы останутся на диске.", style: TextStyle(color: Colors.white38)),
                onTap: () {
                  showDialog(
                    context: context, 
                    builder:(ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF1A1A1A),
                      title: const Text("Очистить всё?", style: TextStyle(color: Colors.white)),
                      content: const Text("Это действие нельзя отменить.", style: TextStyle(color: Colors.white70)),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена", style: TextStyle(color: Colors.white54))),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          onPressed: () async {
                            await ref.read(animeRepoProvider).clearAll();
                            if (ctx.mounted) Navigator.pop(ctx);
                          },
                          child: const Text("Удалить", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}