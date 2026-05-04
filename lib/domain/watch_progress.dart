import 'package:isar/isar.dart';

part 'watch_progress.g.dart';

@collection
class WatchProgress {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true, replace: true)
  late String path;
  
  late int positionSeconds;
  late DateTime updatedAt;
}