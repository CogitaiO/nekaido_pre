import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nekaido_pre/data/services/shikimori_service.dart';
import 'dart:io';

import '../domain/anime.dart';  
import '../presentation/anime_details/anime_details_screen.dart';
import '../../providers/repositories_provider.dart';
import '../presentation/anime_details/dialogs/anime_dialogs.dart';

class AnimeCard extends ConsumerStatefulWidget {
  final Anime anime;
  const AnimeCard({super.key, required this.anime});

  @override
  ConsumerState<AnimeCard> createState() => _AnimeCardState();
}

class _AnimeCardState extends ConsumerState<AnimeCard> {

  bool _isHovered = false;
  //Метод вызова контекстного меню
  void _showContextMenu(BuildContext context, WidgetRef ref, Offset tapPosition) {
    showMenu<String>(
      context: context, 
      color: Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      position: RelativeRect.fromLTRB(
        tapPosition.dx, tapPosition.dy,
        tapPosition.dx, tapPosition.dy,
      ),
      items: [
        const PopupMenuItem(value: 'sync_api', child: Text("Refresh data from the network", style: TextStyle(color: Colors.white))),
        const PopupMenuItem(value: 'edit', child: Text("Edir", style: TextStyle(color: Colors.white))),
        const PopupMenuItem(value: 'collection', child: Text("To the collections", style: TextStyle(color: Colors.white))),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'delete', child: Text("Delete from library", style: TextStyle(color: Colors.redAccent))),
      ],
    ).then((value) {
      if (value == 'delete'){
        _confirmDelete(context, ref);
      } else if (value == 'edit') {
        _showEditDialog(context, ref);
      } else if (value == 'collection') {
       AnimeDialogs.showCollectionDialog(context, ref, widget.anime, Colors.redAccent);
      } else if (value == 'sync_api') {
        _syncWithApi(context, ref);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = 'poster_${widget.anime.id}_library';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => 
              AnimeDetailsScreen(animeId: widget.anime.id, heroTag: heroTag),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      onSecondaryTapDown: (details) {
        _showContextMenu(context, ref, details.globalPosition);
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                   tag:  heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(color: Colors.white10),
                        if (widget.anime.coverUrl != null)
                          widget.anime.coverUrl!.startsWith('http') 
                            ?CachedNetworkImage(
                              imageUrl: widget.anime.coverUrl!,
                              fit: BoxFit.cover,
                              memCacheWidth: 300,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
                              errorWidget: (context, url, error) => const Icon(Icons.heart_broken_rounded, color: Colors.white24, size: 40),
                            )
                          : Image.file(
                              File(widget.anime.coverUrl!),
                              fit: BoxFit.cover,
                              cacheWidth: 300,
                            ),

                        
                            
                        if (widget.anime.coverUrl == null)
                          const Center(child: Icon(Icons.image, color: Colors.white24, size: 40)),

                        Positioned(
                            bottom: 0, left: 0, right: 0, height: 40,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                                  colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent]
                                )
                              ),
                            ),
                          ),
                          if (widget.anime.watchProgress > 0)
                            Positioned(
                              bottom: 0, left: 0, right: 0,
                               child: LinearProgressIndicator(
                                value: widget.anime.watchProgress,
                                 backgroundColor: Colors.transparent,
                                 color: Colors.redAccent,
                                 minHeight: 4,
                               ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.anime.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 13, 
                    color: _isHovered ? Colors.redAccent : Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Delete anime", style: TextStyle(color: Colors.white)),
        content: const Text("The anime will be removed from the database. The video files themselves remain on the disk.", 
                            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
             style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
             onPressed: () {
              ref.read(animeRepoProvider).deleteAnime(widget.anime.id);
              Navigator.pop(ctx);
             },
             child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      )
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: widget.anime.title);
    final coverController =  TextEditingController(text: widget.anime.coverUrl ?? '');

    showDialog(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Edit", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Title", labelStyle: TextStyle(color: Colors.redAccent)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: coverController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "URL posters", 
                labelStyle: TextStyle(color: Colors.redAccent),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.folder_open, color: Colors.redAccent),
                  tooltip: "Select from computer",
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.pickFiles(type: FileType.image);
                    if (result != null && result.files.single.path != null) {
                      coverController.text = result.files.single.path!;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена", style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              ref.read(animeRepoProvider).editAnimeDetails(
                widget.anime, 
                titleController.text, 
                coverController.text.isNotEmpty ? coverController.text : ''
              );
              Navigator.pop(ctx);
            },
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _syncWithApi(BuildContext context, WidgetRef ref) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('We are looking for data for "${widget.anime.title}"...')),
    );
    final shikimori = ShikimoriService();
    final meta = await shikimori.fetchAnimeDetails(widget.anime.title);

    if (meta != null) {
      widget.anime.coverUrl = meta['coverUrl'];
      widget.anime.descripion = meta['description'];

      widget.anime.shikimoriId = int.tryParse(meta['shikimoriId'] ?? '');
      await ref.read(animeRepoProvider).saveAnime(widget.anime);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data updated successfully!'), 
            backgroundColor: Colors.green
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to find data on Shikimori'), 
            backgroundColor: Colors.redAccent
          ),
        );
      }
    }
  }
}