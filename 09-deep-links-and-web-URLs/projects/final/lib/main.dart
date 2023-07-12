import 'package:flutter/material.dart';
import 'package:yummy/login.dart';
import 'package:yummy/restaurant_menu.dart';

import 'constants.dart';
import 'home.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.green;
  ColorScheme? imageColorScheme = const ColorScheme.light();

  final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      // ShellRoute(
      //   builder: (BuildContext context, GoRouterState state, Widget child) {
      //     return Scaffold(
      //       body: child,
      //       /* ... */
      //       bottomNavigationBar: BottomNavigationBar(
      //           /* ... */
      //           ),
      //     );
      //   },
      //   routes: <RouteBase>[
      //     GoRoute(
      //       path: 'details',
      //       builder: (BuildContext context, GoRouterState state) {
      //         return const DetailsScreen();
      //       },
      //     ),
      //   ],
      // ),
      GoRoute(
          path: '/',
          builder: (context, state) {
            return Home(
                tab: int.tryParse(state.queryParameters['tab'] ?? '') ?? 0);
          },
          routes: [
            // ShellRoute(
            //     routes: [
            //       GoRoute(
            //         path: 'store',
            //         builder: (context, state) => Container(color: Colors.blue),
            //       ),
            //     ],
            //     builder:
            //         (BuildContext context, GoRouterState state, Widget child) {
            //       return Container(color: Colors.blue);
            //     })
            GoRoute(
              path: 'store',
              builder: (context, state) => RestaurantMenu(),
            ),
          ]),
      // GoRoute(path: '/restaurant/:merchantId'),
      // GoRoute(path: '/onboarding'),
      // GoRoute(path: '/account'),
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => Home(
      //     title: 'Yummy',
      //     colorSelected: colorSelected,
      //     handleBrightnessChange: handleBrightnessChange,
      //     handleColorSelect: handleColorSelect,
      //   ),
      // ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Yummy',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
    );
  }
}
