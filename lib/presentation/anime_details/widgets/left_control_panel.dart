import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../domain/anime.dart';
import '../../../../providers/repositories_provider.dart';
import '../../player/player_screen.dart';
import '../dialogs/anime_dialogs.dart';
import '../../../../providers/settings_provider.dart';

class LeftControlPanel extends ConsumerWidget {
  final Anime anime;
  final Color accentColor;
  final String heroTag;

  const LeftControlPanel({
    super.key,
    required this.anime,
    required this.accentColor,
    required this.heroTag,
  });

  void _playEpisode(BuildContext context, String path) {
    if (!File(path).existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ошибка:  Файл видео не найден!"), backgroundColor: Colors.redAccent),
      );
      return;
    }
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => PlayerScreen(animeId: anime.id, videoPath: path)),
    );
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Данные для постера
    ImageProvider? imageProvider;
    if (anime.coverUrl != null) {
      imageProvider = anime.coverUrl!.startsWith('http')
        ? CachedNetworkImageProvider(anime.coverUrl!) as ImageProvider
        : FileImage(File(anime.coverUrl!));
    }

    //Логика умной кнопки
    final sortedEpisodes = anime.sortedEpisodes;
    final nextEpisodePath = anime.nextEpisodeToPlay ?? (sortedEpisodes.isNotEmpty ? sortedEpisodes.first : '');
    final nextEpisodeIndex = sortedEpisodes.isNotEmpty ? sortedEpisodes.indexOf(nextEpisodePath) + 1 : 0;
    final isAllWatched = anime.nextEpisodeToPlay == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Hero(
          tag: heroTag, 
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
                image: imageProvider != null ? DecorationImage(image: imageProvider, fit: BoxFit.cover) : null,
                 border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                 boxShadow: [BoxShadow(color: accentColor.withValues(alpha: 0.4), blurRadius: 40, offset: const Offset(0, 20))],
              ),
              child: imageProvider == null
                  ? const Center(child: Icon(Icons.image_not_supported, size: 60, color: Colors.white24)) 
                  : null,
            ),
          )
        ),
        const SizedBox(height: 24),

        if (sortedEpisodes.isNotEmpty)
          ElevatedButton(
            onPressed:  () => _playEpisode(context, nextEpisodePath),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: isAllWatched ? Colors.white24 : accentColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 10,
              shadowColor: accentColor.withValues(alpha: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isAllWatched ? Icons.replay : Icons.play_arrow, size: 26),
                Transform.translate(
                  offset: const Offset(0, -1.5),
                  child: Text(
                    isAllWatched ? "Пересмотреть" : "Эпизод $nextEpisodeIndex",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.1),
                  ),
                ),
                const SizedBox(width: 8)
              ],
            ),
          ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(flex: 2, child: _StatusMenu(anime: anime, accentColor: accentColor)),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _HoverButton(
                icon: Icons.bookmark_add_rounded,
                tooltip: "Подборка",
                accentColor: accentColor,
                onTap: () => AnimeDialogs.showCollectionDialog(context, ref, anime, accentColor),
              )
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _MoreMenu(anime: anime, accentColor: accentColor)
            ),
          ],
        )
      ],
    );
  }
}

class _StatusMenu extends ConsumerWidget {
  final Anime anime;
  final Color accentColor;
  const _StatusMenu({required this.anime, required this.accentColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFF1A1A1A)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () => ref.read(animeRepoProvider).updateStatus(anime.id, AnimeStatus.planned),
          child: const Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
                              child: Text("В планах", style: TextStyle(color: Colors.white))),
        ),
        MenuItemButton(
          onPressed: () => ref.read(animeRepoProvider).updateStatus(anime.id, AnimeStatus.watching),
          child: const Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
                              child: Text("Смотрю", style: TextStyle(color: Colors.blueAccent))),
        ),
        MenuItemButton(
          onPressed: () => ref.read(animeRepoProvider).updateStatus(anime.id, AnimeStatus.completed),
          child: const Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
                                child: Text("Просмотрено", style: TextStyle(color: Colors.green))),
        ),
      ],
      builder: (context,controller, child) {
        return Material(
          color: Colors.white.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.white12)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
             onTap: () => controller.isOpen ? controller.close() : controller.open(),
             child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      anime.status == AnimeStatus.planned ? "В планах" :
                      anime.status == AnimeStatus.watching ? "Смотрю" :
                      anime.status == AnimeStatus.completed ? "Просмотрено" : "Брошено",
                      style: TextStyle(
                        fontSize: 16,  fontWeight: FontWeight.bold,
                         color: anime.status == AnimeStatus.planned ? Colors.white :
                                anime.status == AnimeStatus.watching ? Colors.blueAccent :
                                anime.status == AnimeStatus.completed ? Colors.green : Color(ref.watch(settingsProvider).accentColorValue),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.white54),
                  ],
                ),
             ),
          ),
        );
      },
    );
  }
}

class _MoreMenu extends ConsumerWidget {
  final Anime anime;
  final Color accentColor;
  const _MoreMenu({required this.anime, required this.accentColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(color: Color(0xFF1A1A1A), 
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))),
      ), 
      child: PopupMenuButton<String>(
        tooltip: "Больше опций",
        offset: const Offset(0, 50),
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'stats', child: Row(children:[Icon(Icons.bar_chart, color: Colors.white70, size: 20),
                SizedBox(width: 12), Text("Статистика", style: TextStyle(color: Colors.white))])),
          const PopupMenuItem(value: 'mark_all', child: Row(children:[Icon(Icons.done_all, color: Colors.white70, size: 20),
                SizedBox(width: 12), Text("Отметить всё просмотренным", style: TextStyle(color: Colors.white))])),
          const PopupMenuItem(value: 'folder', child: Row(children:[Icon(Icons.folder_open, color: Colors.white70, size: 20),
                SizedBox(width: 12), Text("Открыть папку на ПК", style: TextStyle(color: Colors.white))])),
          const PopupMenuDivider(),
          const PopupMenuItem(value: 'edit', child: Row(children:[Icon(Icons.edit, color: Colors.white70, size: 20),
                SizedBox(width: 12), Text("Редактировать постер", style: TextStyle(color: Colors.white))])),
        ],
        onSelected: (value) async {
           if (value == 'folder') AnimeDialogs.openFolderInOs(anime.folderPath);
           if (value == 'edit') AnimeDialogs.showEditDialog(context, ref, anime, accentColor);
           if (value == 'stats') AnimeDialogs.showAnimeStatsDialog(context, anime, accentColor);
           if (value == 'mark_all') {
             for (String path in anime.sortedEpisodes) {
               if (!anime.watchedEpisodes.contains(path)) {
                 await ref.read(animeRepoProvider).markEpisodeAsWatched(anime.id, path);
               }
             }
          }
        },
        child: _HoverButton(icon: Icons.more_horiz, tooltip: "Опции", accentColor: accentColor),
      ),
    );
  }
}

class _HoverButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final Color accentColor;
  final VoidCallback? onTap;

  const _HoverButton({required this.icon, required this.tooltip, required this.accentColor, this.onTap});

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
           child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 48,
            decoration: BoxDecoration(
              color: isHovered ? widget.accentColor : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isHovered ? widget.accentColor : Colors.white12),
            ),
            child: Icon(widget.icon, color: isHovered ? Colors.white : Colors.white70, size: 24),
          ),
        ),
      ),
    );
  } 
}