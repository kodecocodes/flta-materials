import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'empty_grocery_screen.dart';
import 'grocery_item_screen.dart';
import 'grocery_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 5
    return Scaffold(
      // 6
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 1
          final manager = Provider.of<GroceryManager>(context, listen: false);
          // 2
          Navigator.push(
            context,
            // 3
            MaterialPageRoute(
              // 4
              builder: (context) => GroceryItemScreen(
                // 5
                onCreate: (item) {
                  // 6
                  manager.addItem(item);
                  // 7
                  Navigator.pop(context);
                },
                onUpdate: (_) {},
              ),
            ),
          );
        },
      ),
      // 7
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    // 1
    return Consumer<GroceryManager>(
      // 2
      builder: (context, manager, child) {
        // 3
        if (manager.groceryItems.isNotEmpty) {
          return GroceryListScreen(manager: manager);
        } else {
          // 4
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
