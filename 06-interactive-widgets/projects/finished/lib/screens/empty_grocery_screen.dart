import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tab_manager.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AspectRatio(
            aspectRatio: 2,
            child: Image.asset("assets/fooderlich_assets/empty_list.png")),
        SizedBox(height: 16),
        Text("No Groceries", style: TextStyle(fontSize: 21)),
        SizedBox(height: 16),
        Text("Shopping for ingredients? Write them down!",
            textAlign: TextAlign.center),
        Consumer<TabManager>(builder: (context, tabState, child) {
          return MaterialButton(
              textColor: Colors.white,
              child: Text("Browse Recipes"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.green,
              onPressed: () {
                tabState.goToRecipes();
              });
        })
      ])),
    );
  }
}
