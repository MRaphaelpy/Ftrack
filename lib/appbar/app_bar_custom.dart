import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../database/db.dart';
import '../theme/theme_provider.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCustom({Key? key}) : super(key: key);

  @override
  State<AppBarCustom> createState() => _AppBarCustomState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarCustomState extends State<AppBarCustom>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = const Duration(milliseconds: 500);

    isPlaying = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _saveAppState();
    }
  }

  void _saveAppState() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    await DB.instance.setThemeMode(themeProvider.isDarkMode);
    await DB.instance.setAnimationState(isPlaying);

    print('App state saved: Theme=${themeProvider.isDarkMode}, Animation=$isPlaying');
  }

  void toggle() {
    const Duration newDuration = Duration(milliseconds: 500);

    if (!isPlaying) {
      _controller.forward();
    } else {
      _controller.duration = newDuration;
      _controller.reverse();
    }
    isPlaying = !isPlaying;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    DB.instance.setThemeMode(themeProvider.isDarkMode);
    DB.instance.setAnimationState(isPlaying);

    Provider.of<ThemeProvider>(context, listen: false).toggleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Center(
        child: Text(
          'FTracking',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Lottie.asset(
            "assets/images/darktorlight.json",
            height: 70,
            width: 70,
            controller: _controller,
          ),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            toggle();
          },
        ),
      ],
      elevation: 4.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }
}
