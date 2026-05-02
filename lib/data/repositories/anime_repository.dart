import 'package:isar/isar.dart';
import '../../domain/anime.dart';
import '../../core/logger.dart'; 

class AnimeRepository {
  final Isar db;
  AnimeRepository(this.db);


  Stream<List<Anime>> watchLibrary() {
    return db.animes
        .filter()
        .isHiddenEqualTo(false)
        .sortByTitle()
        .watch(fireImmediately: true);
  }

  Stream<Anime?> watchAnimeById(Id id) {
    return db.animes.watchObject(id, fireImmediately: true);
  }


  Future<void> addScannedAnime (List<Anime> newAnimes) async {
    try{
      if (newAnimes.isEmpty) return;

      await db.writeTxn(() async{
        await db.animes.putAll(newAnimes);  
      });
    } catch (e,st) {
      talker.handle(e,st,'Ошибка в добавлении сканированного аниме');
    }
  }

  
  //Метод для обновления статуса
  Future<void> updateStatus(Id id, AnimeStatus newStasus) async {
    try {
      await db.writeTxn(() async {
        final anime = await db.animes.get(id);
        if (anime != null) {
          anime.status = newStasus;
          await db.animes.put(anime);
          talker.info('Статус аниме обновлен');
        }
      });
    } catch (e,st) {
      talker.handle(e,st,"Ошибка обновления статуса");
    }
  }

  //Метод для фиксации просмотра серии
  Future<void> markEpisodeAsWatched (Id id, String episodePath) async {
    try{
      await db.writeTxn(() async{
        final anime = await db.animes.get(id);
        if (anime!=null) {
          final uniqueEpisodes = {...anime.watchedEpisodes, episodePath}.toList();
          anime.watchedEpisodes = uniqueEpisodes;
          await db.animes.put(anime);
          talker.info('Эпизод просмотрен в "${anime.title}"');
        }
      });
    }catch(e,st) {
      talker.handle(e,st,"Ошибка в пометке аниме просмотренным");
    }
  }

  Future<Anime?> getAnimeByTitle(String title) async {
    try {
      return await db.animes.filter().titleEqualTo(title).findFirst();
    } catch (e,st) {
      talker.handle(e,st,'Ошибка в получении аниме по названию');
      return null;
    }
  }

  Future<Anime?> getAnimeById(int id) async {
    return await db.animes.get(id);
  }

   Future<void> savePlaybackPosition(int id, String path, int seconds) async {
    try {
      await db.writeTxn(() async {
        final anime = await db.animes.get(id);
        if (anime != null) {
          final updatedList = List<PlaybackEntry>.from(anime.playbackPositions);
          // Создаем новую мапу на основе старой, чтобы Isar увидел изменения
          final index = updatedList.indexWhere((e) => e.path == path);
          if (index != -1) {
            // Если нашли — обновляем секунды
            updatedList[index].position = seconds;
          } else {
            updatedList.add(
              PlaybackEntry()
                ..path = path
                ..position = seconds,
            );
          }
          anime.playbackPositions = updatedList;
          await db.animes.put(anime);
        }
      });
    } catch (e, st) {
      talker.handle(e, st, "Ошибка сохранения позиции видео");
    }
  }

    Future<void> editAnimeDetails(Anime anime, String newTitle, String newCoverUrl) async {
    await db.writeTxn(() async {
      anime.title = newTitle;
      
      // Если ссылка есть - сохраняем если юзер стер строку - делаем null
      anime.coverUrl = newCoverUrl.isNotEmpty ? newCoverUrl : null;
      
      await db.animes.put(anime);
    });
  }

  //Сохранение заметок
  Future<void> addNote(Id id, String epPath, int seconds, String text) async {
    try {
      await db.writeTxn(() async {
        final anime = await db.animes.get(id);
        if (anime == null) return;

        final note = EpisodeNote()
          ..episodePath = epPath
          ..timestampSeconds = seconds
          ..text = text
          ..createdAt = DateTime.now();

        anime.notes = [...anime.notes, note];
        await db.animes.put(anime);
        talker.info('Заметка добавлена к "${anime.title}" на ${seconds}с.');
      });
    } catch (e, st) {
      talker.handle(e, st, 'Ошибка сохранения заметки');
    }
  }
  
  Future <void> deleteNote(Id id, DateTime createdAt) async {
    try {
      await db.writeTxn(() async {
        final anime = await db.animes.get(id);
        if (anime == null) return;

        final updateNotes = anime.notes.where((n) => n.createdAt != createdAt).toList();

        anime.notes = updateNotes;
        await db.animes.put(anime);
        talker.info('Note is delete from "${anime.title}"');
      });
    } catch (e, st) {
      talker.handle(e, st, "Ошибка удаления ошибки");
    }
  }

  // Удаление всей базы (для настроек)
  Future<void> clearAll() async {
    await db.writeTxn(() => db.animes.clear());
    talker.warning('БД БЫЛА ОЧИЩЕНА');
  }

  //Сохранение аниме
  Future<void> saveAnime(Anime anime) async{
    await db.writeTxn(() async{
      await db.animes.put(anime);
    });
  }

  //Удаление из бд
  Future<void> deleteAnime(Id id) async {
    try{
      await db.writeTxn(() async{
        db.animes.delete(id);
      });
    }catch(e, st) {
      talker.handle(e,st, "Ошибка удаления аниме по айди");
    }
  }

}