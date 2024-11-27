import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:expensentracker/theme/dark_theme.dart' as d;
import 'package:expensentracker/theme/light_theme.dart' as l;

class ThemeNotifier extends StateNotifier<ThemeData> {
  // ThemeNotifier(super.key):super
  ThemeNotifier(super.state);

  // ignore: unused_field
  // final ThemeData _themeData = d.darkTheme;

  // ThemeData get themeData {
  //   return _themeData;
  // }

  void toggleTheme() {
    if (state == l.lightTheme) {
      state = d.darkTheme;
    } else {
      state = l.lightTheme;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier(l.lightTheme);
});
