import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/player/player_provider.dart';
import '../../../../providers/library_provider.dart'; // Нужен для получения названия аниме
import '../../../../widgets/custom_title_bar.dart'; 
import 'player_progress_bar.dart';

class PlayerOverlay extends ConsumerWidget {
  const PlayerOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(playerProvider.select((s) => s.isUiVisible));
    final activeSkip = ref.watch(playerProvider.select((s) => s.activeSkip));
    
    // Реактивно следим за текущим видео и плейлистом
    final videoPath = ref.watch(playerProvider.select((s) => s.videoPath)) ?? '';
    final animeId = ref.watch(playerProvider.select((s) => s.animeId));
    final playlist = ref.watch(playerProvider.select((s) => s.playlist));
    
    final isOp = activeSkip?.type == 'op';

    // === ГЕНЕРАЦИЯ КРАСИВОГО НАЗВАНИЯ ===
    String displayTitle = "Загрузка...";
    
    if (videoPath.isNotEmpty) {
      // Запасной технический вариант (если аниме не найдено)
      displayTitle = videoPath.split(Platform.pathSeparator).last; 
    }

    if (animeId != null) {
      // Получаем аниме из базы данных
      final animeSync = ref.watch(animeDetailsProvider(animeId));
      if (animeSync.value != null) {
        final anime = animeSync.value!;
        // Вычисляем номер серии (+1, так как индексы начинаются с нуля)
        final epIndex = playlist.indexOf(videoPath) + 1; 
        
        if (epIndex > 0) {
          displayTitle = '${anime.title} Эпизод $epIndex';
        } else {
          displayTitle = anime.title;
        }
      }
    }

    return Stack(
      children:[
        
        // Основной UI плеера с плавным появлением
        IgnorePointer(
          ignoring: !isVisible,
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Stack(
              children:[
                // === ВЕРХНЯЯ ПАНЕЛЬ (Градиент) ===
                Positioned(
                  top: 0, left: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors:[Colors.black.withValues(alpha: 0.8), Colors.transparent],
                      ),
                    ),
                    child: CustomTitleBar(
                      backgroundColor: Colors.transparent, 
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          const SizedBox(width: 4),
                          Tooltip(
                            message: "Back",
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.black26.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white24),
                            ),
                            textStyle: const TextStyle(
                              color: Colors.white38,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            waitDuration: const Duration(milliseconds: 500), // через сколько появится
                            showDuration: const Duration(seconds: 2),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      title: Expanded(
                        child: Text(
                          displayTitle, // <--- ИСПОЛЬЗУЕМ КРАСИВОЕ НАЗВАНИЕ
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),

                // === НИЖНЯЯ ПАНЕЛЬ (Градиент) ===
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 64, bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter, end: Alignment.topCenter,
                        colors:[Colors.black.withValues(alpha: 0.9), Colors.transparent],
                      ),
                    ),
                    child: const PlayerProgressBar(),
                  ),
                ),
              ],
            ),
          ),
        ),

        // === КНОПКА ПРОПУСКА ОПЕНИНГА/ЭНДИНГА ===
        Positioned(
          bottom: 120, 
          right: 48,   
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeInBack,
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: activeSkip == null
                ? const SizedBox.shrink(key: ValueKey('empty_skip'))
                : ElevatedButton.icon(
                    key: const ValueKey('skip_button'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 10,
                    ),
                    icon: const Icon(Icons.fast_forward_rounded, size: 24),
                    label: Text(
                      isOp ? "Пропустить опенинг" : "Пропустить эндинг",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      ref.read(playerProvider.notifier).seek(
                        Duration(milliseconds: (activeSkip.endTime * 1000).toInt())
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}