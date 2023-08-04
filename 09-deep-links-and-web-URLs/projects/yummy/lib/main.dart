import 'dart:ui';

import 'package:flutter/material.dart';
import 'login.dart';
import 'models/auth.dart';
import 'models/orders.dart';
import 'models/restaurant.dart';
import 'models/shopping_cart.dart';
import 'restaurant_page.dart';

import 'constants.dart';
import 'home.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad
      };
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

  /// Manage user's orders submitted
  final OrdersManager _orders = OrdersManager();

  late final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    redirect: _appRedirect,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            Login(onLogIn: (Credentials credentials) async {
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
                shoppingCart: _shoppingCart,
                ordersManager: _orders,
                handleBrightnessChange: handleBrightnessChange,
                handleColorSelect: handleColorSelect,
                colorSelected: colorSelected,
                tab: int.tryParse(state.queryParameters['tab'] ?? '') ?? 0);
          },
          routes: [
            GoRoute(
                path: 'restaurant/:id',
                builder: (context, state) {
                  final id = 
                    int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  final restaurant = restaurants[id];
                  return RestaurantPage(
                    restaurant: restaurant,
                    shoppingCart: _shoppingCart,
                    ordersManager: _orders,
                  );
                }),
          ]),
    ],
  );

  String? _appRedirect(BuildContext context, GoRouterState state) {
    final loggedIn = _auth.loggedIn;
    final isOnLoginPage = state.matchedLocation == '/login';

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
      scrollBehavior: CustomScrollBehavior(),
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
