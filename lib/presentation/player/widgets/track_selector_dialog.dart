import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import '../../../../providers/player/player_provider.dart';

class TrackSelectorDialog  extends ConsumerWidget{
  const TrackSelectorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final notifier = ref.read(playerProvider.notifier);

    return Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
      child: SizedBox(
        width: 400,
        height: 500,
        child: DefaultTabController(
          length: 2, 
          child: Column(
            children: [
              const TabBar(
                indicatorColor: Colors.redAccent,
                labelColor: Colors.redAccent,
                unselectedLabelColor: Colors.white54,
                tabs: [
                  Tab(icon: Icon(Icons.audiotrack_rounded), text: "Озвучка"),
                  Tab(icon: Icon(Icons.subtitles_rounded), text: "Субтитры"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children:[
                    _buildTrackList<AudioTrack>(
                      tracks: playerState.audioTracks, 
                      currentTrack: playerState.currentAudio, 
                      onSelect: (track) => notifier.setAudioTrack(track),
                      externalSubsMap: playerState.externalSubsMap,
                    ),
                    _buildTrackList<SubtitleTrack>(
                      tracks: playerState.subtitleTracks,
                      currentTrack: playerState.currentSubtitle,
                      onSelect: (track) => notifier.setSubtitleTrack(track),
                      externalSubsMap: playerState.externalSubsMap, 
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildTrackList<T>({
    required List<T> tracks,
    required T? currentTrack,
    required Function(T) onSelect,
    required Map<String, List<String>> externalSubsMap, // Принимаем новую мапу
  }) {
    if (tracks.isEmpty) {
      return const Center(child: Text("Нет доступных дорожек", style: TextStyle(color: Colors.white54)));
    }

    // 1. ПРЕДВЫЧИСЛЯЕМ ИМЕНА (Защита от багов при скролле)
    final Map<T, String> trackNames = {};
    final Map<String, int> fileCounters = {}; // Счетчик для одинаковых файлов

    for (var track in tracks) {
      String name = "Неизвестно";
      
      if (track is AudioTrack) {
        name = track.title ?? track.language ?? track.id;
      } else if (track is SubtitleTrack) {
        String baseName = track.title ?? track.language ?? track.id;
        
        if (baseName.endsWith('.ass') || baseName.endsWith('.srt')) {
          if (externalSubsMap.containsKey(baseName)) {
            final studios = externalSubsMap[baseName]!;
            int count = fileCounters[baseName] ?? 0;
            
            // Берем нужную студию из списка по очереди
            if (count < studios.length) {
              name = "[${studios[count]}] $baseName";
              fileCounters[baseName] = count + 1; // Увеличиваем счетчик для этого файла
            } else {
              name = baseName;
            }
          } else {
            name = baseName;
          }
        } else {
          name = baseName;
        }
      }
      
      // Красивые имена для служебных дорожек
      if (track is AudioTrack && track.id == 'auto') name = "Автоматически";
      if (track is AudioTrack && track.id == 'no') name = "Отключить";
      if (track is SubtitleTrack && track.id == 'auto') name = "Автоматически";
      if (track is SubtitleTrack && track.id == 'no') name = "Отключить";

      trackNames[track] = name;
    }

    // 2. СТРОИМ СПИСОК
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        final isSelected = currentTrack == track;
        final trackName = trackNames[track]!; // Берем готовое вычисленное имя

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          title: Text(
            trackName, 
            style: TextStyle(
              color: isSelected ? Colors.redAccent : Colors.white, 
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
            ),
            maxLines: 2, 
            overflow: TextOverflow.ellipsis,
          ),
          trailing: isSelected ? const Icon(Icons.check, color: Colors.redAccent) : null,
          onTap: () {
            onSelect(track);
            Navigator.pop(context);
          },
        );
      },
    );
  }

}