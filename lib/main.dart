import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_appwidget.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider<ThemeProvider>.value(
      value: themeProvider,
      child: const MyApp(),
    ),
  );
}
