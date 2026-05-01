import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/library_provider.dart';
import '../../providers/color_provider.dart';
import '../../widgets/escapable.dart';
import '../../widgets/custom_title_bar.dart'; 
import 'widgets/ambient_background.dart';
import 'widgets/left_control_panel.dart';
import 'widgets/right_info_panel.dart';

class AnimeDetailsScreen extends ConsumerWidget{
  final int animeId;
  final String heroTag;

  const AnimeDetailsScreen({
    super.key,
    required this.animeId,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeSync = ref.watch(animeDetailsProvider(animeId));
    
    return Escapable(
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F0F),
        body: Column(
          children: [
            const CustomTitleBar(),
            Expanded(
              child: animeSync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
                error: (err, _) => Center(child: Text("Ошибка: $err", style: const TextStyle(color: Colors.white))),  
                data: (anime) {
                  if (anime == null) return const Center(child: Text("Тайтл не найден")); 

                  final accentColor = ref.watch(animeColorProvider(anime)).value ?? Colors.transparent;

                  return Stack(
                    children: [
                      AmbientBackground(color: accentColor),

                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsetsGeometry.all(16.0),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 1100),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(32, 10, 32, 40),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 280,
                                        child: LeftControlPanel(
                                          anime: anime, 
                                          accentColor: accentColor, 
                                          heroTag: heroTag
                                        ),
                                      ),
                                      const SizedBox(width: 48),
                                      Expanded(
                                        child: RightInfoPanel(
                                          anime: anime,
                                          accentColor: accentColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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