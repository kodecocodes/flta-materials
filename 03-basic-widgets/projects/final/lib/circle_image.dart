import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  // 1
  const CircleImage({
    Key? key,
    this.imageProvider,
    this.imageRadius = 20,
  }) : super(key: key);

  // 2
  final double imageRadius;
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    // 3
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: imageRadius,
      // 4
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
