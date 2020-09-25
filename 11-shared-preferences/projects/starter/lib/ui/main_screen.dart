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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes/ui/colors.dart';

import 'myrecipes/my_recipes_list.dart';
import 'recipes/recipe_list.dart';
import 'shopping/shopping_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>  {
  int _selectedIndex = 0;
  List<Widget> pageList = List<Widget>();

  @override
  void initState() {
    super.initState();
    pageList.add(RecipeList());
    pageList.add(MyRecipesList());
    pageList.add(ShoppingList());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    switch(_selectedIndex) {
      case 0:
        title = 'Recipes';
        break;
      case 1:
        title = 'Bookmarks';
        break;
      case 2:
        title = 'Groceries';
        break;
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  'assets/images/icon_recipe.svg',
                  color: _selectedIndex == 0 ? green : Colors.grey ,
                  semanticsLabel: 'Recipes'
              ),
              title: Text("Recipes")
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/images/icon_bookmarks.svg',
                    color: _selectedIndex == 1 ? green : Colors.grey ,
                    semanticsLabel: 'Bookmarks'
                ),
              title: Text("Bookmarks")
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'assets/images/icon_shopping_list.svg',
                    color: _selectedIndex == 2 ? green : Colors.grey ,
                    semanticsLabel: 'Groceries'
                ),
              title: Text("Groceries")
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: green,
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: pageList,
        ),
      ),
    );
  }

}
