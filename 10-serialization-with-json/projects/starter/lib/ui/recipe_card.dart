import 'package:flutter/material.dart';

// TODO: Replace with new class
Widget recipeStringCard(String image, String label) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
          // TODO: Replace with image from recipe
          child: Image.asset(
            'assets/images/pizza_w700.png',
            height: 200,
            width: 200,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            // TODO: Replace with label from recipe
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            '320CAL',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    ),
  );
}