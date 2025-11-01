import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:micropolis_assessment/core/data/datasource/shared_prefrences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<bool> changeAppTheme(bool isDark);

  bool? getCurrentAppTheme();
}

@LazySingleton(as: ThemeLocalDataSource)
class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> changeAppTheme(bool isDark) async {
    final result = await sharedPreferences.setBool(
      SharedPreferencesKeys.isDarkMode,
      isDark,
    );

    return result;
  }

  @override
  bool? getCurrentAppTheme() {
    if (!sharedPreferences.containsKey(SharedPreferencesKeys.isDarkMode)) {
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool isDarkMode = (brightness == Brightness.dark);
      return isDarkMode;
    } else {
      final result = sharedPreferences.getBool(
        SharedPreferencesKeys.isDarkMode,
      );
      return result;
    }
  }
}
