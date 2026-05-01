import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'library_provider.dart';

// Провайдер, который управляет списком добавленных папок
final savedFoldersProvider = StateNotifierProvider<SavedFoldersNotifier, List<String>>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return SavedFoldersNotifier(prefs);
});

final playerSettingsProvider = StateNotifierProvider<PlayerSettingsNotifier, PlayerSettings>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return PlayerSettingsNotifier(prefs);
});

class SavedFoldersNotifier extends StateNotifier<List<String>> {
  final SharedPreferences _prefs;
  static const _key = 'library_folders';
  SavedFoldersNotifier(this._prefs) : super(_prefs.getStringList(_key) ??[]);

  void addFolder(String path) {
    if (!state.contains(path)) {
      state = [...state, path];
      _prefs.setStringList(_key, state);
    }
  }

  void removeFolder(String path) {
    state = state.where((p) => p != path).toList();
    _prefs.setStringList(_key, state);
  }
}

class PlayerSettings {
  final String audioLanguage; 
  final String subLanguage;   
  final String hwdec;

  PlayerSettings({required this.audioLanguage, required this.subLanguage, required this.hwdec});

  PlayerSettings copyWith({String? audioLanguage, String? subLanguage, String? hwdec}) {
    return PlayerSettings(
      audioLanguage: audioLanguage ?? this.audioLanguage,
      subLanguage: subLanguage ?? this.subLanguage,
      hwdec: hwdec ?? this.hwdec,
    );
  }
}

class PlayerSettingsNotifier extends StateNotifier<PlayerSettings> {
  final SharedPreferences _prefs;

  PlayerSettingsNotifier(this._prefs) : super(PlayerSettings(
    // По умолчанию: Японская озвучка, Русские субтитры
    audioLanguage: _prefs.getString('pref_alang') ?? 'jpn,jp,eng,en,rus,ru',
    subLanguage: _prefs.getString('pref_slang') ?? 'rus,ru,eng,en',
    hwdec: _prefs.getString('pref_hwdec') ?? 'auto',
  ));

  void updateAudioLang(String langCode) {
    state = state.copyWith(audioLanguage: langCode);
    _prefs.setString('pref_alang', langCode);
  }

  void updateSubLang(String langCode) {
    state = state.copyWith(subLanguage: langCode);
    _prefs.setString('pref_slang', langCode);
  }

  void updateHwdec(String mode) {
    state = state.copyWith(hwdec: mode);
    _prefs.setString('pref_hwdec', mode);
  }
}