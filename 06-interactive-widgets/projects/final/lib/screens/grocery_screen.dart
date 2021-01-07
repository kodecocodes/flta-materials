/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'empty_grocery_screen.dart';
import '../models/models.dart';
import 'package:provider/provider.dart';
import 'grocery_item_screen.dart';
import 'grocery_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1
    return Scaffold(
      // 2
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // 1
            GroceryManager manager = Provider.of<GroceryManager>(context, listen: false);
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
                )));
          }),
      // 3
      body: buildGroceryScreen());
  }

  buildGroceryScreen() {
      // 4
      return Consumer<GroceryManager>(
        // 5
        builder: (context, manager, child) {
        // 6
        if (manager.groceryItems.isNotEmpty) {
          return GroceryListScreen(manager: manager);
        } else {
          // 7
          return EmptyGroceryScreen();
        }
      });
    }
}