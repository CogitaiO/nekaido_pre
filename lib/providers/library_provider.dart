import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nekaido_pre/data/services/file_discovery_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repositories_provider.dart';
import '../domain/anime.dart';

// Главный поток из бд
final libraryProvider = StreamProvider<List<Anime>>((ref) {
  final repo = ref.watch(animeRepoProvider);
  return repo.watchLibrary();
});

// Провайдер для строки поиска
final searchQueryProvider = StateProvider<String>((ref) => "");

// Индекс сайдбара (0 - Все, 1 - Смотрю, 2 - В планах, 3 - Просмотрено, 4 - Брошено, 5 - Подборки)
final selectedSidebarIndexProvider = StateProvider<int>((ref) => 0);

// Провайдер для хранения выбранной кастомной подборки
final selectedCollectionProvider = StateProvider<String?>((ref) => null);

// Динамическое извлечение ВСЕХ существующих подборок из БД
final allCollectionsProvider = Provider<List<String>>((ref) {
  final allAnime = ref.watch(libraryProvider).value ??[];
  final Set<String> uniqueCollections = {};
  
  for (var anime in allAnime) {
    uniqueCollections.addAll(anime.customCollections);
  }
  
  final list = uniqueCollections.toList();
  list.sort(); // Сортируем по алфавиту
  return list;
});

// Провайдер для фильтрации (ОБНОВЛЕННЫЙ)
final filteredAnimeProvider = Provider<List<Anime>>((ref) {
  final allAnime = ref.watch(libraryProvider).value ??[];
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final index = ref.watch(selectedSidebarIndexProvider);
  final selectedCollection = ref.watch(selectedCollectionProvider);

  return allAnime.where((anime) {
    // 1. Проверка на строку поиска
    if (query.isNotEmpty && !anime.title.toLowerCase().contains(query)) {
      return false;
    }

    // 2. Проверка на статус или подборку
    switch (index) {
      case 1: return anime.status == AnimeStatus.watching;
      case 2: return anime.status == AnimeStatus.planned;
      case 3: return anime.status == AnimeStatus.completed;
      case 4: return anime.status == AnimeStatus.dropped;
      case 5: // Режим подборок
        if (selectedCollection == null) return false; // Если подборка не выбрана, ничего не показываем
        return anime.customCollections.contains(selectedCollection);
      case 0: 
      default:
        return true; // "Вся библиотека"
    }
  }).toList();
});

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