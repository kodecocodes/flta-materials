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

import 'recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  RecipeDetail(this.recipe);

  @override
  _RecipeDetailState createState() {
    return _RecipeDetailState(recipe);
  }
}

class _RecipeDetailState extends State {
  final Recipe recipe;
  int _sliderVal = 1;

  _RecipeDetailState(this.recipe);

  @override
  Widget build(BuildContext context) {
    // 1
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.label),
      ),
      // 2
      body: SafeArea(
        // 3
        child: Column(
          children: <Widget>[
            // 4
            Container(
              height: 300,
              width: double.infinity,
              child: Image(image: AssetImage(recipe.imageUrl)),
            ),
            // 5
            SizedBox(
              height: 4,
            ),
            // 6
            Text(
              recipe.label,
              style: TextStyle(fontSize: 18),
            ),
            // 7
            Expanded(
              // 8
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final ingredient = recipe.ingredients[index];
                  // 9
                  return Text("${ingredient.quantity * _sliderVal} ${ingredient.measure} ${ingredient.name}");
                },
              ),
            ),
            Slider(
              // 10
              min: 1,
              max: 10,
              divisions: 10,
              // 11
              label: "${_sliderVal * recipe.servings} servings",
              // 12
              value: _sliderVal.toDouble(),
              // 13
              onChanged: (newValue) {
                setState(() {
                  _sliderVal = newValue.round();
                });
              },
              // 14
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
