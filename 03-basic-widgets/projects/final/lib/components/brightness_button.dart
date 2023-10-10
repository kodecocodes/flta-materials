import 'package:flutter/material.dart';

class BrightnessButton extends StatelessWidget {
  const BrightnessButton({
    Key? key,
    required this.handleBrightnessChange,
  }) : super(key: key);

  final Function handleBrightnessChange;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return IconButton(
      icon: isBright
          ? const Icon(Icons.dark_mode_outlined)
          : const Icon(Icons.light_mode_outlined),
      onPressed: () => handleBrightnessChange(!isBright),
    );
  }
}
