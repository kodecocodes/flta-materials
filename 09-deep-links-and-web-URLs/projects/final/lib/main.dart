import 'package:flutter/material.dart';
import 'package:yummy/login.dart';
import 'package:yummy/models/auth.dart';
import 'package:yummy/models/shopping_cart.dart';
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
  ThemeMode themeMode = ThemeMode.dark;
  ColorSeed colorSelected = ColorSeed.blue;
  ColorScheme? imageColorScheme = const ColorScheme.light();

  /// Authentication to manage user login session
  final YummyAuth _auth = YummyAuth();

  /// Manage user's shopping cart for the items they order.
  final ShoppingCart _shoppingCart = ShoppingCart();

  late final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    redirect: _appRedirect,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            Login(
              onLogIn: (Credentials credentials) async {
                _auth
                  .signIn(credentials.username, credentials.password)
                  .then((_) => context.go('/'));
        }),
      ),
      GoRoute(
          path: '/',
          builder: (context, state) {
            return Home(
                auth: _auth,
                handleBrightnessChange: handleBrightnessChange,
                handleColorSelect: handleColorSelect,
                colorSelected: colorSelected,
                tab: int.tryParse(state.queryParameters['tab'] ?? '') ?? 0);
          },
          routes: [
            GoRoute(
              path: 'merchant',
              builder: (context, state) => const RestaurantMenu(),
            ),
          ]),
    ],
  );

  String? _appRedirect(BuildContext context, GoRouterState state) {
    final bool loggedIn = _auth.loggedIn;
    final bool isOnLoginPage = state.matchedLocation == '/login';

    // Go to /login if the user is not signed in
    if (!loggedIn) {
      return '/login';
    }
    // Go to root of app / if the user is already signed in
    else if (loggedIn && isOnLoginPage) {
      return '/';
    }

    // no redirect
    return null;
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Yummy',
      themeMode: themeMode,
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
