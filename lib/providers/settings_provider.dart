import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'library_provider.dart';

final savedFoldersProvider = StateNotifierProvider<SavedFoldersNotifier, List<String>>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return SavedFoldersNotifier(prefs);
});

class SavedFoldersNotifier extends StateNotifier<List<String>>{
  final SharedPreferences _prefs;
  static const _key = 'library_folders';
  SavedFoldersNotifier(this._prefs) : super(_prefs.getStringList(_key) ?? []);

  void addFolder(String path) {
    if(!state.contains(path)) {
      state = [...state, path];
      _prefs.setStringList(_key, state);
    }
  }

  void removeFolder(String path) {
    state = state.where((p) => p != path).toList();
    _prefs.setStringList(_key, state);
  }
}

class AppSettings{
  final String audioLanguage; 
  final String subLanguage;   
  final String hwdec;
  final bool discordRpcEnabled;
  final bool autoSkipEnabled;
  final int accentColorValue;

  AppSettings({
    required this.audioLanguage, 
    required this.subLanguage, 
    required this.hwdec,
    required this.discordRpcEnabled,
    required this.autoSkipEnabled,
    required this.accentColorValue,
  });

  AppSettings copyWith({
    String? audioLanguage, 
    String? subLanguage, 
    String? hwdec,
    bool? discordRpcEnabled,
    bool? autoSkipEnabled,
    int? accentColorValue,
  }) {
    return AppSettings(
      audioLanguage: audioLanguage ?? this.audioLanguage,
      subLanguage: subLanguage ?? this.subLanguage,
      hwdec: hwdec ?? this.hwdec,
      discordRpcEnabled: discordRpcEnabled ?? this.discordRpcEnabled,
      autoSkipEnabled: autoSkipEnabled ?? this.autoSkipEnabled,
      accentColorValue: accentColorValue ?? this.accentColorValue
    );
  }
}

final settingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return AppSettingsNotifier(prefs);
});

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  final SharedPreferences _prefs;

  AppSettingsNotifier(this._prefs) : super(AppSettings(
    audioLanguage: _prefs.getString('pref_alang') ?? 'jpn,jp,eng,en,rus,ru', 
    subLanguage: _prefs.getString('pref_slang') ?? 'eng,en,rus,ru', 
    hwdec: _prefs.getString('pref_hwdec') ?? 'auto-safe', 
    discordRpcEnabled: _prefs.getBool('pref_discord') ?? true,
    autoSkipEnabled:  _prefs.getBool('pref_autoskip') ?? false,
    accentColorValue: _prefs.getInt('pref_color') ?? Colors.redAccent.toARGB32(),
  )); 

  void updateAudioLang(String langCode) {
    state = state.copyWith(audioLanguage: langCode);
    _prefs.setString('pref_alang', langCode);
  }

  void updateSubLang(String subLang) {
    state = state.copyWith(subLanguage: subLang);
    _prefs.setString('pref_slang', subLang);
  }

  void updateHwdec (String mode) {
    state = state.copyWith(hwdec: mode);
    _prefs.setString('pref_hwdec', mode);
  }

  void toggleDiscordRpc(bool value) {
    state = state.copyWith(discordRpcEnabled: value);
    _prefs.setBool('pref_discord', value);
  }

  void toggleAutoSkip(bool value) {
    state = state.copyWith(autoSkipEnabled: value);
    _prefs.setBool('pref_autoskip', value);
  }

  void updateAccentColor(Color color) {
    state = state.copyWith(accentColorValue: color.toARGB32());
    _prefs.setInt('pref', color.toARGB32());
  }
}