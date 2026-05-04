class EpisodeParser {
  static int? extractEpisodeNumber(String fileName) {
    final regex = RegExp(r'(?:\s|-|\[|[Ee]p\s*)(\d{1,4})(?:v\d+)?(?:\s|-|\]|\.)');
    for (final match in regex.allMatches(fileName)) {
      final val = int.tryParse(match.group(1)!);
      if (val != null && val != 1080 && val != 720 && val != 480 && val < 2000) {
        return val;
      }
    }
    
    final fallback = RegExp(r'(\d+)(?:v\d+)?\.\w+$').firstMatch(fileName);
    if (fallback != null) return int.tryParse(fallback.group(1)!);
    
    return null;
  }
}