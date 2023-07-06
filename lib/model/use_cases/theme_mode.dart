import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/provider/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeNotifierProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this.ref) : super(ThemeMode.system) {
    final currentIndex = prefs.getInt(key);
    if (currentIndex == null) return;

    state = ThemeMode.values.firstWhere(
      (element) => element.index == currentIndex,
    );
  }

  final Ref ref;
  final key = 'themeMode';
  SharedPreferences get prefs => ref.read(sharedPreferencesProvider);

  void update(ThemeMode mode) {
    state = mode;
    prefs.setInt(key, mode.index);
  }
}
