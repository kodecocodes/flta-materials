import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/main_screen.dart';

Future<void> main() async {
  // TODO: Call _setupLogging()
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// TODO: Add _setupLogging()

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}
