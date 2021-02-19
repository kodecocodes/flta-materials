import 'package:flutter/material.dart';

void main() {
  // 1
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key key}) : super(key: key);
  // 2
  @override
  Widget build(BuildContext context) {
    // 3
    return MaterialApp(
      title: 'Fooderlich',
      // 4
      home: Scaffold(
        // 5
        appBar: AppBar(title: const Text('Fooderlich')),
        body: const Center(child: Text('Let\'s get cooking 👩‍🍳')),
      ),
    );
  }
}
