import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

import '../domain/anime.dart';
import 'repositories_provider.dart';

final animeColorProvider = FutureProvider.family<Color, Anime>((ref, anime) async {
  if (anime.ambientColorValue != null) {
    return Color(anime.ambientColorValue!);
  }

  if (anime.coverUrl == null || anime.coverUrl!.isEmpty) {
    return Colors.redAccent;
  }

  try {
    ImageProvider provider = anime.coverUrl!.startsWith('http')
        ? NetworkImage(anime.coverUrl!) as ImageProvider
        : FileImage(File(anime.coverUrl!));

    final resizedProvider = ResizeImage(provider, width: 100);

    // 5. Генерируем палитру
    final palette = await PaletteGenerator.fromImageProvider(
      resizedProvider,
      maximumColorCount: 10,
    );

    final calcColor = palette.vibrantColor?.color 
                   ?? palette.dominantColor?.color 
                   ?? palette.darkVibrantColor?.color 
                   ?? Colors.redAccent;

    anime.ambientColorValue = calcColor.value;
    await ref.read(animeRepoProvider).saveAnime(anime);

    return calcColor;
  } catch (e) {
    return Colors.redAccent;
  }
});