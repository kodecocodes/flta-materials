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
import 'package:provider/provider.dart';
import 'screens/grocery_list_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/recipes_screen.dart';
import 'models/tab_manager.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    GroceryListScreen()
  ];

  _onItemTapped(int index, TabManager state) {
    state.goToTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(builder: (context, tabState, child) {
      return Scaffold(
          appBar: AppBar(
              title: Text("Fooderlich",
                  style: Theme.of(context).textTheme.headline6)),
          body: pages[tabState.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Theme.of(context).textSelectionColor,
              currentIndex: tabState.selectedTab,
              onTap: (index) {
                _onItemTapped(index, tabState);
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: 'Recipes'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: 'To Buy'),
              ]));
    });
  }
}
