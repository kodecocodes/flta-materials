import 'package:logging/logging.dart';
import 'package:recipes/mock_service/mock_service.dart';
import 'data/repository.dart';
import 'network/recipe_service.dart';
import 'network/service_interface.dart';
import 'ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:provider/provider.dart';
import 'data/sqlite/sqlite_repository.dart';
import 'data/moor/moor_repository.dart';


Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
  // SqliteRepository repository = SqliteRepository();
  MoorRepository repository = MoorRepository();
  await repository.init();
  runApp(MyApp(repository));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  final Repository repository;
  const MyApp(this.repository) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<Repository>(
            lazy: false,
            create: (_) => repository,
            dispose: (_, Repository repository) => repository.close(),
          ),
          Provider<ServiceInterface>(
            // create: (_) => MockService()..create(),
            create: (_) => RecipeService.create(),
            lazy: false,
          ),
        ],
        child: MaterialApp(
          title: 'Recipes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainScreen(),
        ));
  }
}
