import 'package:flutter/material.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: Create theme
    return MaterialApp(
      // TODO: Add theme
      title: 'Fooderlich',
      home: Scaffold(
        // TODO: Style the title
        appBar: AppBar(title: const Text('Fooderlich')),
        // TODO: Style the body text
        body: const Center(child: Text('Let\'s get cooking 👩‍🍳')),
      ),
    );
  }
}
