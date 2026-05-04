import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../domain/watch_progress.dart';

final watchProgressRepoProvider = Provider<WatchProgressRepository>((ref) {
  throw UnimplementedError('watchProgressRepoProvider не был инициализирован в main.dart');
});

class WatchProgressRepository {
  final Isar db;

  WatchProgressRepository(this.db);

  Future<void> saveProgress(String path, int seconds) async {
    final progress = WatchProgress()
      ..path = path
      ..positionSeconds = seconds
      ..updatedAt = DateTime.now();

    await db.writeTxn(() async {
      await db.collection<WatchProgress>().put(progress); 
    });
  }

  Future<int> getProgress(String path) async {
    final record = await db.collection<WatchProgress>().filter().pathEqualTo(path).findFirst();
    return record?.positionSeconds ?? 0;
  }
}