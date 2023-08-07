import 'dart:ui';

import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'models/auth.dart';
import 'models/orders.dart';
import 'models/shopping_cart.dart';

import 'constants.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: Login(onLogIn: (credentials) {}),
    );
  }
}
