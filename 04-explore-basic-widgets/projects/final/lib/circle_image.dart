import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  CircleImage(
    this.imageProvider, {
    this.radius = 20,
  });

  final double radius;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    // Haha this is great, a circle avatar within a circle avatar. Could make a great joke in the book.
    return CircleAvatar(
      backgroundColor: Colors.white, 
      radius: radius, 
      child: CircleAvatar(
        radius: radius - 5,
        backgroundImage: imageProvider,
    ));
  }
}