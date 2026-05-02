import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekaido_pre/providers/library_provider.dart';

import '../../../../domain/anime.dart';
import '../../../../providers/repositories_provider.dart';

class AnimeDialogs {
  static void openFolderInOs(String? path) {
     if (path == null) return;
     if (Platform.isWindows) Process.run('explorer', [path]);
     else if (Platform.isMacOS) Process.run('open', [path]);
     else if (Platform.isLinux) Process.run('xdg-open', [path]);
  }

  //Диалог статистики
  static void showAnimeStatsDialog(BuildContext context, Anime anime, Color accentColor) {
    int watchedCount = anime.watchedEpisodes.length;
    double totalHours = (watchedCount * 24) / 60;
    String dateAdded = "${anime.dateAdded.day.toString().padLeft(2, '0')}.${anime.dateAdded.month.toString().padLeft(2, '0')}.${anime.dateAdded.year}";

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
          title: Row(children: [Icon(Icons.bar_chart, color: accentColor), 
                                const SizedBox(width: 8), const Text("Информация", style: TextStyle(color: Colors.white))],),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatRow("Добавлено:", dateAdded), const SizedBox(height: 12),
              _buildStatRow("Просмотрено:", "$watchedCount из ${anime.sortedEpisodes.length}"), const SizedBox(height: 12),
              _buildStatRow("Потрачено:", "~${totalHours.toStringAsFixed(1)} часов"), const SizedBox(height: 12),
               _buildStatRow("Папка:", anime.folderPath ?? "Неизвестно"),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Закрыть", style: TextStyle(color: accentColor)))],
        );
      }
    );
  }

  //Диалог редактирования
  static void showEditDialog(BuildContext context, WidgetRef ref, Anime anime, Color accentColor) {
    TextEditingController titleController = TextEditingController(text: anime.title);
    TextEditingController coverController = TextEditingController(text: anime.coverUrl ?? '');

    showDialog(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
        title: Row(children:[Icon(Icons.edit, color: accentColor), 
                            const SizedBox(width: 8), const Text("Редактировать", style: TextStyle(color: Colors.white))]),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller:  titleController, style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(hintText: "Название", focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: accentColor))),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: coverController, style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                              hintText: "URL Постера", 
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.image_search_rounded,color: accentColor),
                                onPressed: () async {
                                  FilePickerResult? result = await FilePicker.pickFiles(type: FileType.image);
                                  if (result != null) coverController.text = result.files.single.path!;
                                },
                              ),
                )
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена", style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accentColor),
            onPressed: () {
              ref.read(animeRepoProvider).editAnimeDetails(anime, titleController.text.trim(), coverController.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text("Сохранить", style: TextStyle(color: Colors.white)),
          ),
        ],
      )
    );
  }

  //Диалог подборок

  static void showCollectionDialog(BuildContext context, WidgetRef ref, Anime anime, Color accentColor) {
    TextEditingController controller = TextEditingController();

    final allCollections = ref.read(allCollectionsProvider);
    final  availableCollections = allCollections.where((c) => !anime.customCollections.contains(c)).toList();

    showDialog(
      context: context, 
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A1A1A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
              title: const Text("In collections", style: TextStyle(color: Colors.white)),
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "New collections",
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
                        hintStyle: const TextStyle(color: Colors.white38), 
                      ),
                    ),

                    if (availableCollections.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text("Or choose from existing ones", style: TextStyle(color: Colors.white54, fontSize: 12)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                          children: availableCollections.map((colName) {
                          return ActionChip(
                            label: Text(colName, style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.white.withValues(alpha: 0.1),
                            side: BorderSide.none,
                            onPressed: () {
                              controller.text = colName;
                            },
                          );
                        }).toList(),
                      ),
                    ]
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: accentColor),
                  onPressed: () async {
                    final text = controller.text.trim();
                    if(text.isNotEmpty) {
                      if(!anime.customCollections.contains(text)) {
                        anime.customCollections = [...anime.customCollections, text];
                        await ref.read(animeRepoProvider).saveAnime(anime);
                      }
                      if (context.mounted) Navigator.pop(context);
                    }
                  },
                  child: const Text("Add", style: TextStyle(color: Colors.white)),
                  
                ),
              ],
            );
          },
        );
      }
    );
  }

  static Widget _buildStatRow(String label, String value) => Row (
    children: [
      Expanded(flex: 2, child: Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13))),
      Expanded(flex: 3, child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold))),
    ],
  );
}