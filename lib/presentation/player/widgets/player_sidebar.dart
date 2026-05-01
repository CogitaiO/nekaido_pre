import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../../providers/player/player_provider.dart';
import '../../../../providers/library_provider.dart';

class PlayerSidebar extends ConsumerWidget{
  const PlayerSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = ref.watch(playerProvider.select((s) => s.isSidebarOpen));

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      top: 0,
      bottom: 0,
      right: isOpen ? 0 : -350,
      width: 350,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151515).withValues(alpha: 0.95),
            border: Border(left: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20, offset: const Offset(-5, 0))
            ]
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Меню", style: TextStyle(color: Colors.white54, fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () => ref.read(playerProvider.notifier).toggleSideBar(),
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  indicatorColor: Colors.redAccent,
                  labelColor: Colors.redAccent,
                  unselectedLabelColor: Colors.white54,
                  dividerColor: Colors.white12,
                  tabs: [
                    Tab(icon: Icon(Icons.video_library_rounded), text: "Серии"),
                    Tab(icon: Icon(Icons.bookmark_rounded),text: "Заметки",)
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children:[
                      _buildEpisodeList(ref),
                      _buildNotesList(ref),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEpisodeList(WidgetRef ref) {
    final animeId = ref.watch(playerProvider.select((s) => s.animeId));
    final playlist = ref.watch(playerProvider.select((s) => s.playlist));
    final currentVideo = ref.watch(playerProvider.select((s) => s.videoPath));

    if(animeId == null || playlist.isEmpty) {
      return const Center(child: Text("Плейлист пуст", style: TextStyle(color: Colors.white54)));
    }

    final animeAsync = ref.watch(animeDetailsProvider(animeId));

    return animeAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
      error: (_, __) => const Center(child: Text("Ошибка загрузки", style: TextStyle(color: Colors.white54))),
      data: (anime) {
        if (anime == null) return const SizedBox.shrink();
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            final path = playlist[index];
            final isCurrent = path == currentVideo;
            final isWatched = anime.watchedEpisodes.contains(path);
            final fileName = path.split(Platform.pathSeparator).last;

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              tileColor: isCurrent ? Colors.redAccent.withValues(alpha: 0.1) : Colors.transparent,
              leading: Icon(
                isCurrent ? Icons.play_circle_filled_rounded :
                (isWatched ? Icons.check_circle_outline : Icons.circle_outlined),
                color: isCurrent ? Colors.redAccent : (isWatched ? Colors.lightGreen : Colors.white38),
              ),
              title: Text(
                "Эпизод ${index + 1}",
                style: TextStyle(
                  color: isCurrent ? Colors.redAccent : Colors.white,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal
                ),
              ),
              subtitle: Text(
                fileName,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                final notifier = ref.read(playerProvider.notifier);
                notifier.toggleSideBar();

                if(!isCurrent) {
                  notifier.loadVideo(animeId, path);
                }
              },
            );
          },
        );
      }
    );
  }

  Widget _buildNotesList (WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark_border_rounded, size: 48, color: Colors.white.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          const Text("Заметки скоро появятся", style: TextStyle(color: Colors.white54)),
          const SizedBox(height: 8),
          const Text("Здесь будут ваши таймкоды\nивыши мысли",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white38, fontSize: 12)
          ),
        ],
      ),
    );
  }
}