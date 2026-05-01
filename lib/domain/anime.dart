import 'package:isar/isar.dart';
import 'package:collection/collection.dart';
part 'anime.g.dart'; 

enum AnimeStatus{
  planned,
  watching,
  completed,
  dropped
}


@collection
class Anime {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String title;
  int? shikimoriId;
  
  String? folderPath;
  String? coverUrl;
  String? descripion;

  int? ambientColorValue; 
  DateTime dateAdded = DateTime.now();

  List<String> episodePaths = [];
  List<String> watchedEpisodes = [];
  List<EpisodeNote> notes =[];
  List<PlaybackEntry> playbackPositions = []; 
  @enumerated
  AnimeStatus status = AnimeStatus.planned;
  bool isHidden = false;
  List<String> customCollections =[];
  List<EpisodeSkipData> skipData =[]; 
  


  //Геттер сортировки
  List<String> get sortedEpisodes {
    return List.from(episodePaths)..sort(compareNatural);
  }

  //Геттер прогресса
  double get watchProgress {
    if(episodePaths.isEmpty) return 0.0;
    return watchedEpisodes.length / episodePaths.length;
    
  }

  //Геттер для определения пути следующей серии
  String? get nextEpisodeToPlay {
    final sorted = sortedEpisodes;
    for (var ep in sorted) {
      if(!watchedEpisodes.contains(ep)){
        return ep;
      }
    }
    return null;
  }
  //Геттер для процнета просмотра
  String get progressPercentage {
    if (episodePaths.isEmpty) return "0%";
    final percent = (watchProgress * 100).toInt();
    return "$percent%";
  }
  //Количество серий 
  String get progressFraction {
    return "${watchedEpisodes.length} / ${episodePaths.length}";
  }


}

@embedded
class EpisodeNote {
  String? episodePath;      
  int? timestampSeconds;     
  String? text;              
  DateTime? createdAt;      
}

@embedded
class PlaybackEntry {
  String? path;
  int? position;
}

@embedded
class EpisodeSkipData {
  String? episodePath; 
  List<SkipIntervalDb> intervals =[]; 
}

@embedded
class SkipIntervalDb {
  String? type; // 'op' или 'ed'
  double? startTime;
  double? endTime;
}