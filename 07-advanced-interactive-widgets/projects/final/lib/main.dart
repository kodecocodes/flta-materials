
import 'package:flutter/material.dart';
import 'constants.dart';
import 'home.dart';
import 'dart:ui';

import 'models/cart_manager.dart';
import 'models/order_manager.dart';

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


  /// Manage user's shopping cart for the items they order.
  final CartManager _cartManager = CartManager();

  /// Manage user's orders submitted
  final OrderManager _orderManager = OrderManager();


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
      home: Home(
          cartManager: _cartManager,
          ordersManager: _orderManager,
          handleBrightnessChange: handleBrightnessChange,
          handleColorSelect: handleColorSelect,
          colorSelected: colorSelected),
    );
  }
}
