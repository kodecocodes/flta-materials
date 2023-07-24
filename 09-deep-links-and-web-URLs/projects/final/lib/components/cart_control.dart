import 'package:flutter/material.dart';

class CartControl extends StatefulWidget {
  final Function(int) onCartNumberChanged;

  const CartControl({required this.onCartNumberChanged, super.key});

  @override
  _CartControlState createState() => _CartControlState();
}

class _CartControlState extends State<CartControl> {
  int cartNumber = 0; // Initialize cart number

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Minus button
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (cartNumber > 0) {
                  cartNumber--;
                }
              });
              widget.onCartNumberChanged(cartNumber); // Notify the parent
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
              widget.onCartNumberChanged(cartNumber); // Notify the parent
            },
          ),

          // Spacer to push the Add Cart button to the end
          const Spacer(),

          // Add cart button
          FilledButton(
            onPressed: () {
              // Handle adding to cart action
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
