import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekaido_pre/providers/repositories_provider.dart';
import 'dart:io';
import '../../../../providers/player/player_provider.dart';
import '../../../../providers/library_provider.dart';
import 'package:flutter/services.dart';
import '../../../../providers/settings_provider.dart';
class PlayerSidebar extends ConsumerWidget{
  final FocusNode playerFocusNode; 
  const PlayerSidebar({super.key, required this.playerFocusNode});

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
                      const Text("Menu", style: TextStyle(color: Colors.white54, fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () => {
                          FocusManager.instance.primaryFocus?.unfocus(),
                          ref.read(playerProvider.notifier).toggleSideBar(),
                          playerFocusNode.requestFocus(),
                        },
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
                    Tab(icon: Icon(Icons.video_library_rounded), text: "Episodes"),
                    Tab(icon: Icon(Icons.bookmark_rounded),text: "Notes",)
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children:[
                      _buildEpisodeList(ref),
                      const _EpisodeNoteTab(),
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
      return const Center(child: Text("Playlist is empty", style: TextStyle(color: Colors.white54)));
    }

    final animeAsync = ref.watch(animeDetailsProvider(animeId));

    return animeAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
      error: (_, __) => const Center(child: Text("Loading error", style: TextStyle(color: Colors.white54))),
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
              tileColor: isCurrent ? Color(ref.watch(settingsProvider).accentColorValue).withValues(alpha: 0.1) : Colors.transparent,
              leading: Icon(
                isCurrent ? Icons.play_circle_filled_rounded :
                (isWatched ? Icons.check_circle_outline : Icons.circle_outlined),
                color: isCurrent ? Color(ref.watch(settingsProvider).accentColorValue) : (isWatched ? Colors.lightGreen : Colors.white38),
              ),
              title: Text(
                "Эпизод ${index + 1}",
                style: TextStyle(
                  color: isCurrent ? Color(ref.watch(settingsProvider).accentColorValue) : Colors.white,
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
}

class _EpisodeNoteTab extends ConsumerStatefulWidget {
  const _EpisodeNoteTab();

  @override
  ConsumerState<_EpisodeNoteTab> createState() => _EpisodeNoteTabState();
}

class _EpisodeNoteTabState extends ConsumerState<_EpisodeNoteTab> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if(_focusNode.hasFocus) {
        final player = ref.read(playerProvider);
        if(player.isPlaying) {
          ref.read(playerProvider.notifier).togglePlay();
        }
      }
    });
  }

  @override
  void dispose () {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds~/ 60).toString().padLeft(2,'0');
    final s = (seconds % 60).toString().padLeft(2,'0');
    return '$m:$s';
  }

  void _saveNote(int animeId, String episodePath) {
    final text = _textController.text.trim();
    if(text.isEmpty) return;

    final currentPositionSeconds = ref.read(playerProvider).position.inSeconds;

    ref.read(animeRepoProvider).addNote(animeId, episodePath, currentPositionSeconds, text);

    _textController.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build (BuildContext context) {
    final animeId = ref.watch(playerProvider.select((s) => s.animeId));
    final currentPath = ref.watch(playerProvider.select((s) => s.videoPath));

    if (animeId == null || currentPath == null) {
      return const Center(child: Text("Turn on video for notes", style: TextStyle(color: Colors.white54)));
    }

    final animeAsync = ref.watch(animeDetailsProvider(animeId));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Add a note to the current frame...",
                    hintStyle: const TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onSubmitted: (_) => _saveNote(animeId, currentPath),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Color(ref.watch(settingsProvider).accentColorValue).withValues(alpha: 0.2)),
                icon: const Icon(Icons.add_rounded,color: Colors.redAccent),
                onPressed: () => _saveNote(animeId, currentPath),
              ),
            ],
          ),
        ),

        const Divider(color: Colors.white12, height: 1),

        Expanded(
          child: animeAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
            error: (e, _) => Center(child: Text("Error: $e", style: const TextStyle(color: Colors.redAccent))),
            data: (anime) {
              if (anime == null) return const SizedBox.shrink();
              final episodeNotes = anime.notes.where((n) => n.episodePath == currentPath).toList()
                     ..sort((a,b) => (a.timestampSeconds ?? 0).compareTo(b.timestampSeconds ?? 0));
              if (episodeNotes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_note_rounded,size: 48 ,color: Colors.white.withValues(alpha: 0.1)),
                      const SizedBox(height: 16),
                      const Text("There are no notes for this series", style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: episodeNotes.length,
                itemBuilder: (context, index) {
                  final note = episodeNotes[index];
                  final timestamp = note.timestampSeconds ?? 0;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          ref.read(playerProvider.notifier).seek(Duration(seconds: timestamp));
                          ref.read(playerProvider.notifier).showUi();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(ref.watch(settingsProvider).accentColorValue).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Color(ref.watch(settingsProvider).accentColorValue).withValues(alpha: 0.5)),
                          ),
                          child: Text(
                            _formatTime(timestamp),
                            style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                    title: Text(note.text ?? '', style: const TextStyle(color: Colors.white, fontSize: 14)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.white38, size: 20),
                      onPressed: () {
                        if (note.createdAt != null) {
                          ref.read(animeRepoProvider).deleteNote(animeId, note.createdAt!);
                        }
                      },
                      hoverColor: Color(ref.watch(settingsProvider).accentColorValue).withValues(alpha: 0.2),
                    ),
                  );
                },
              );
            }
          )
        ),
      ],
    );
  }
}