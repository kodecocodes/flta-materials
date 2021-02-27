import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({Key key, this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) {
            final item = groceryItems[index];
            return Dismissible(
                key: Key(item.id),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  manager.deleteItem(index);
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
                  onTap: () {
                    Provider.of<AppStateManager>(context, listen: false)
                        .groceryItemTapped(item, index);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => GroceryItemScreen(
                    //           originalItem: item,
                    //           onUpdate: (item) {
                    //             manager.updateItem(item, index);
                    //             Navigator.pop(context);
                    //           },
                    //         )));
                  },
                ));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          }),
    );
  }
}
