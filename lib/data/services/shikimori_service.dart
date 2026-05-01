import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/logger.dart';

class ShikimoriService {
  static const _baseUrl = 'https://shikimori.one';

  Future<Map<String, String>?> fetchAnimeDetails(String title) async {
    try {
      final searchUrl = Uri.parse('$_baseUrl/api/animes?search=${Uri.encodeComponent(title)}&limit=1');

      final searchRes = await http.get(searchUrl);
      if (searchRes.statusCode != 200) return null;

      final searchData = jsonDecode(searchRes.body) as List;
      if (searchData.isEmpty) return null;

      final animeId = searchData[0]['id'];

      final detailsUrl = Uri.parse('$_baseUrl/api/animes/$animeId');
      final detailsRes = await http.get(detailsUrl);
      if (detailsRes.statusCode != 200) return null;

      final detailsData = jsonDecode(detailsRes.body);

      final posterUrl = '$_baseUrl${detailsData['image']['original']}';

      final rawDescription = detailsData['description'] ?? detailsData['russian'] ?? "Нет описания";
      final description = _cleanBbCode(rawDescription);

      return {
        'shikimoriId': animeId.toString(),
        'coverUrl' : posterUrl,
        'description': description,
      };
    } catch(e, st) {
       talker.handle(e, st, "Ошибка парсинга Shikimori для: $title");
       return null;
    }
  }
  String _cleanBbCode(String text) {
  return text.replaceAll(RegExp(r'\[/?.*?\]'), '');
  }
}