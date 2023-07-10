import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/memory_repository.dart';
import 'providers.dart';
import 'ui/main_screen.dart';
import 'ui/theme/theme.dart';
import 'utils.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  if (isDesktop()) {
    await DesktopWindow.setWindowSize(const Size(600, 600));
    await DesktopWindow.setMinWindowSize(const Size(260, 600));
  }
  globalSharedPreferences = await SharedPreferences.getInstance();
  globalRepository = MemoryRepository();
  await globalRepository.init();
  runApp(const ProviderScope(child: MyApp()));
}

void _setupLogging() {
  putLumberdashToWork(withClients: [
    ColorizeLumberdash(),
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode currentMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: [
        PlatformMenu(label: 'File', menus: [
          PlatformMenuItem(
              label: 'Dark Mode',
              onSelected: () {
                setState(() {
                  currentMode = ThemeMode.dark;
                });
              }),
          PlatformMenuItem(
              label: 'Light Mode',
              onSelected: () {
                setState(() {
                  currentMode = ThemeMode.light;
                });
              }),
          PlatformMenuItem(
            label: 'Quit',
            onSelected: () {
              setState(() {
                SystemNavigator.pop();
              });
            },
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyQ, meta: true),
          ),
        ])
      ],
      child: MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        themeMode: currentMode,
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        home: const MainScreen(),
      ),
    );
  }
}
