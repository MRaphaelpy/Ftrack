import 'package:flutter/material.dart';
import 'package:frastreio2/pages/inicial_page/inicial_page.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ftracking',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const InicialPage(),
    );
  }
}
