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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class RecipeDetails extends StatelessWidget {

  RecipeDetails();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CachedNetworkImage(
                  imageUrl: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                  alignment: Alignment.topLeft,
                  fit: BoxFit.fill,
                  width: size.width,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: shim),
                  child: BackButton(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Chicken Vesuvio",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Chip(
                label: Text('16CAL'),
              )),
          SizedBox(
            height: 16,
          ),
          Center(
            child: RaisedButton.icon(
              color: green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                'assets/images/icon_bookmark.svg',
                color: Colors.white,
              ),
              label: Text(
                "Bookmark",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ))));
  }
}
