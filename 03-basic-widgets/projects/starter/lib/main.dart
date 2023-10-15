import 'package:flutter/material.dart';

void main() {
  // 1
  runApp(const Yummy());
}

class Yummy extends StatelessWidget {
  // TODO: Setup default theme

  const Yummy({super.key});

  // TODO: Add changeTheme above here

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Yummy';

    return MaterialApp(
      title: appTitle,
s      // TODO: Add theme
      // TODO: Apply Home widget
      home: Scaffold(
        appBar: AppBar(
          // TODO: Add action buttons
          elevation: 4.0,
          title: const Text(
            appTitle,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        body: const Center(
          child: Text(
            'You Hungry?😋',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
