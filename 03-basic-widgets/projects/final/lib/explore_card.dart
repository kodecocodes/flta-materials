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
import 'package:fooderlich/fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/mag2.png"), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(const Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            // TODO 5: Add dark overlay BoxDecoration
            Container(
              decoration: BoxDecoration(
                // 1
                color: Colors.black.withOpacity(0.6),
                // 2
                borderRadius: BorderRadius.all(const Radius.circular(10.0)),
              ),
            ),
            // TODO 6: Add Container, Column, Icon and Text
            Container(
              // 3
              padding: EdgeInsets.all(16),
              // 4
              child: Column(
                // 5
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 6
                  Icon(Icons.book, color: Colors.white, size: 40),
                  // 7
                  SizedBox(height: 8),
                  // 8
                  Text("Recipe Trends", style: FooderlichTheme.darkTextTheme.headline2),
                  // 9
                  SizedBox(height: 30),
                ],
              ),
            ),
            // TODO 7: Add Center widget with Chip widget children
            // 10
            Center(
              // 11
              child: Wrap(
                // 12
                alignment: WrapAlignment.start,
                // 13
                spacing: 12,
                // 14
                children: [
                  Chip(
                    label: Text("Healthy", style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      print("delete");
                    },
                  ),
                  Chip(
                    label: Text("Vegan", style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      print("delete");
                    },
                  ),
                  Chip(
                    label: Text("Carrots", style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
