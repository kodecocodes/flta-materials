import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  runApp(Fooderlich());
}

class Fooderlich extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = FooderlichTheme.dark();
    return MaterialApp(theme: theme, title: "Fooderlich", home: Home());
  }
}
