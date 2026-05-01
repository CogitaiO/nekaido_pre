import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/logger.dart';

class SkipInterval {
  final String type; 
  final double startTime;
  final double endTime;

  SkipInterval({required this.type, required this.startTime, required this.endTime});
}

class AniSkipService {
  Future<List<SkipInterval>> getSkipTimes(int malId, int episodeNumber) async {
    try {
      // ВАЖНО: Добавляем episodeLength=0, чтобы сервер игнорировал разницу в миллисекундах
      // между релизами (SubsPlease, AniLibria и т.д.) и отдавал таймкоды всегда!
      final url = Uri.parse('https://api.aniskip.com/v2/skip-times/$malId/$episodeNumber?types=op&types=ed&episodeLength=0');
      
      // Добавляем User-Agent (Правило хорошего тона для открытых API, чтобы нас не забанили)
      final response = await http.get(url, headers: {
        'User-Agent': 'NekaidoPro/1.0',
      }).timeout(const Duration(seconds: 5));

      // Если сервер вернул ошибку, теперь мы УВИДИМ её в логах!
      if (response.statusCode != 200) {
        talker.warning('AniSkip: Ошибка сервера ${response.statusCode}. Ответ: ${response.body}');
        return[];
      }

      final data = jsonDecode(response.body);
      if (data['found'] != true) return[];

      List<SkipInterval> intervals = [];
      for (var result in data['results']) {
        final interval = result['interval'];
        intervals.add(SkipInterval(
          type: result['skipType'],
          startTime: (interval['startTime'] as num).toDouble(),
          endTime: (interval['endTime'] as num).toDouble(),
        ));
      }
      
      talker.info('AniSkip: Успех! Найдено ${intervals.length} пропусков для эпизода $episodeNumber');
      return intervals;
    } catch (e) {
      talker.error('AniSkip: Критическая ошибка сети ($e)');
      return[];
    }
  }
}