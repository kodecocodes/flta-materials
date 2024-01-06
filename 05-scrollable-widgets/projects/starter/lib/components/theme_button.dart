import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.changeThemeMode,
  });

  final Function changeThemeMode;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return IconButton(
      icon: isBright
          ? const Icon(Icons.dark_mode_outlined) //
          : const Icon(Icons.light_mode_outlined),
      onPressed: () => changeThemeMode(!isBright),
    );
  }
}
