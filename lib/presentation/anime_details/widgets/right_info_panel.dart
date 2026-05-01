import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../domain/anime.dart';
import '../../player/player_screen.dart';

class RightInfoPanel extends StatelessWidget {
  final Anime anime;
  final Color accentColor;

  const RightInfoPanel({
    super.key,
    required this.anime,
    required this.accentColor,
  });

  void _playEpisode(BuildContext context, String path) {
    if (!File(path).existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Файл не найден!"), backgroundColor: Colors.redAccent));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlayerScreen(animeId: anime.id, videoPath: path)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortedEpisodes = anime.sortedEpisodes;
    final fileExtension = sortedEpisodes.isNotEmpty ? sortedEpisodes.first.split('.').last.toUpperCase() : "UNKNOWN";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        // === ЗАГОЛОВОК ===
        Text(
          anime.title,
          style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.2),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),

        // === БЕЙДЖИ ===
        Row(
          children:[
            _buildInfoChip(Icons.video_library, "Серий: ${sortedEpisodes.length}"),
            const SizedBox(width: 12),
            _buildInfoChip(Icons.memory, fileExtension),
            const SizedBox(width: 12),
            Expanded(child: _buildInfoChip(Icons.folder, anime.folderPath?.split(Platform.pathSeparator).last ?? "Неизвестно")),
          ],
        ),
        const SizedBox(height: 24),

        // === ОПИСАНИЕ ===
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Text(
            anime.descripion ?? "Описание пока отсутствует. Обновите данные из сети.",
            style: TextStyle(color: anime.descripion == null ? Colors.white38 : Colors.white70, fontSize: 14, height: 1.5),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 32),

        // === СПИСОК ЭПИЗОДОВ ===
        const Text("Список эпизодов", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 16),
        
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: sortedEpisodes.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.white12, height: 1, indent: 20, endIndent: 20),
                itemBuilder: (context, index) {
                  final episodePath = sortedEpisodes[index];
                  final isWatched = anime.watchedEpisodes.contains(episodePath);

                  return _EpisodeTile(
                    index: index + 1,
                    isWatched: isWatched,
                    accentColor: accentColor,
                    onTap: () => _playEpisode(context, episodePath),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:[
          Icon(icon, size: 14, color: Colors.white70),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _EpisodeTile extends StatefulWidget {
  final int index;
  final bool isWatched;
  final Color accentColor;
  final VoidCallback onTap;

  const _EpisodeTile({required this.index, required this.isWatched, required this.accentColor, required this.onTap});

  @override
  State<_EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<_EpisodeTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(color: isHovered ? Colors.white.withValues(alpha: 0.05) : Colors.transparent),
          child: Row(
            children:[
              SizedBox(width: 40, child: Text("${widget.index}", style: TextStyle(color: widget.isWatched ? Colors.white38 : (isHovered ? Colors.white : Colors.white70), fontSize: 18, fontWeight: FontWeight.bold))),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text("Эпизод ${widget.index}", style: TextStyle(color: widget.isWatched ? Colors.white38 : Colors.white, fontSize: 16, fontWeight: FontWeight.w600))])),
              AnimatedScale(
                scale: isHovered ? 1.2 : 1.0, duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.isWatched ? Icons.check_circle : (isHovered ? Icons.play_circle_fill : Icons.play_circle_outline),
                  color: widget.isWatched ? Colors.green : (isHovered ? widget.accentColor : Colors.white54),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}