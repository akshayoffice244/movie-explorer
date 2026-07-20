import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeRepository {
  static const String boxName = 'theme_box';
  static const String key = 'isDark';

  Box get _box => Hive.box(boxName);

  Future<void> saveTheme(
      ThemeMode mode,
      ) async {
    await _box.put(
      key,
      mode == ThemeMode.dark,
    );
  }

  ThemeMode getTheme() {
    final isDark =
    _box.get(key, defaultValue: false);

    return isDark
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}