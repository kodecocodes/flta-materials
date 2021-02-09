import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({Key key, this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    final groceryItems = manager.groceryItems;
    // 2
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // 3
      child: ListView.separated(
          // 4
          itemCount: groceryItems.length,
          itemBuilder: (context, index) {
            final item = groceryItems[index];
            // 1
            return Dismissible(
              // 1
              key: Key(item.id),
              // 2
              background: Container(color: Colors.red),
              // 3
              onDismissed: (direction) {
                // 4
                manager.deleteItem(index);
                // 5
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} dismissed')));
              },
              child: InkWell(
                          child: GroceryTile(
                            key: Key(item.id),
                            item: item,
                            onComplete: (change) {
                              manager.completeItem(index, change);
                          }),
                          // 2
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GroceryItemScreen(
                                      originalItem: item,
                                      // 3
                                      onUpdate: (item) {
                                        // 4
                                        manager.updateItem(item, index);
                                        // 5
                                        Navigator.pop(context);
                                      },
                                    )));
                          },
                        )
            );
          },
          // 8
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          }),
    );
  }
}