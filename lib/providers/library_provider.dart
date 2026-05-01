import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekaido_pre/data/services/file_discovery_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repositories_provider.dart';
import '../domain/anime.dart';

//Главный поток из бд
final libraryProvider = StreamProvider<List<Anime>>((ref) {
  final repo = ref.watch(animeRepoProvider);
  return repo.watchLibrary();
});

//Провайдер для строки поиска
final searchQueryProvider = StateProvider<String>((ref) => "");

final statusFilterProvider = StateProvider<AnimeStatus?>((ref) => null);

//Провайдер для фильтрации
final filteredAnimeProvider = Provider<List<Anime>>((ref) {
  final allAnime = ref.watch(libraryProvider).value ?? [];
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final status = ref.watch(statusFilterProvider);

  return allAnime.where((anime) {
    //Проверка на статус аниме
    final matchStatus = status == null || anime.status == status;
    //Проверка на название в поиске  
    final matchTitle = anime.title.toLowerCase().contains(query);

    return matchTitle && matchStatus;
  }).toList();
});

final selectedSidebarIndexProvider = StateProvider<int>((ref) => 0);

//Провайдер для получения информации об аниме, по его ID

final animeDetailsProvider = StreamProvider.family<Anime?, int>((ref, id) {
  final repo = ref.watch(animeRepoProvider);
  return repo.watchAnimeById(id);
});

final scannerProvider = Provider<FileDiscoveryService>((ref) {
  final repo = ref.watch(animeRepoProvider);
  return FileDiscoveryService(repo);
});

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});