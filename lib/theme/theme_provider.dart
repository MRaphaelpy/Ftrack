// theme_provider.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme = lightTheme;
  bool isPlaying = false;

  // Chave para armazenar o tema no SharedPreferences
  static const String _themeKey = 'theme_key';
  static const String _animationKey = 'animation_key';
  bool get isDarkMode => currentTheme == darkTheme;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeKey) ?? false;
    isPlaying = prefs.getBool(_animationKey) ?? false;

    currentTheme = isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    currentTheme = currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();

    // Salva o modo de tema atual no SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, currentTheme == darkTheme);
    prefs.setBool(_animationKey, isPlaying);
  }

  void toggleAnimation() async{
    isPlaying = !isPlaying;
    // Salva o estado da animação no SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_animationKey, isPlaying);

    notifyListeners();
  }
}
