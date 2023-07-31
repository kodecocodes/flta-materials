import 'package:flutter/material.dart';

class CartControl extends StatefulWidget {
  final Function(int) addToCart;

  const CartControl({required this.addToCart, super.key});

  @override
  State<CartControl> createState() => _CartControlState();
}

class _CartControlState extends State<CartControl> {
  int cartNumber = 1; // Initialize cart number

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Minus button
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (cartNumber > 1) {
                cartNumber--;
              }
            });
          },
        ),

        // Container with cart number
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: colorTheme.onPrimary, // light gray background
          child: Text(cartNumber.toString()),
        ),

        // Plus button
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              cartNumber++;
            });
          },
        ),

        // Spacer to push the Add Cart button to the end
        const Spacer(),

        // Add cart button
        FilledButton(
          onPressed: () {
            widget.addToCart(cartNumber);
          },
          child: const Text('Add to Cart'),
        ),
      ],
    );
  }
}
