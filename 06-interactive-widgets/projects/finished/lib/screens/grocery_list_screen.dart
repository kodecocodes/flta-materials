import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/grocery_manager.dart';
import '../components/grocery_tile.dart';
import '../screens/empty_grocery_screen.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatefulWidget {
  @override
  _GroceryListScreenState createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  @override
  Widget build(BuildContext context) {
    GroceryManager manager =
        Provider.of<GroceryManager>(context, listen: false);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GroceryItemScreen(
                            onCreate: (item) {
                              manager.addItem(item);
                              // manager.addItem(item);
                              Navigator.pop(context);
                            },
                          )));
            }),
        body: buildGroceryScreen());
  }

  buildGroceryScreen() {
    // GroceryManager manager = Provider.of<GroceryManager>(context, listen: false);
    return Consumer<GroceryManager>(builder: (context, manager, child) {
      var groceryItems = manager.groceryItems;
      if (groceryItems.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              itemCount: groceryItems.length,
              itemBuilder: (context, index) {
                var item = groceryItems[index];
                return Dismissible(
                    key: Key(item.id),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      manager.deleteItem(index);
                      // Show a snackbar. This snackbar could also contain "Undo" actions.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("${item.title} dismissed")));
                    },
                    child: InkWell(
                        child: GroceryTile(
                            key: Key(item.id),
                            item: item,
                            onComplete: (change) {
                              manager.completeItem(index, change);
                            }),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroceryItemScreen(
                                        originalItem: item,
                                        onUpdate: (item) {
                                          manager.updateItem(item, index);
                                          Navigator.pop(context);
                                        },
                                      )));
                        }));
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16);
              }),
        );
      } else {
        return EmptyGroceryScreen();
      }
    });
  }
}
