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
import 'dart:math';

import '../../network/recipe_service.dart';
import 'package:chopper/chopper.dart';
import '../../network/model_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../recipe_card.dart';
import '../recipes/recipe_details.dart';
import '../../network/recipe_model.dart';
import 'package:flutter/material.dart';

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  static const String prefIndex = "previousSearches";

  TextEditingController searchTextController;
  ScrollController _scrollController = ScrollController();
  List<APIHits> currentSearchList = List();
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = List<String>();

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: "");
    _scrollController
      ..addListener(() {
        var triggerFetchMoreSize =
            0.7 * _scrollController.position.maxScrollExtent;

        if (_scrollController.position.pixels > triggerFetchMoreSize) {
          if (hasMore &&
              currentEndPosition < currentCount &&
              !loading &&
              !inErrorState) {
            setState(() {
              loading = true;
              currentStartPosition = currentEndPosition;
              currentEndPosition =
                  min(currentStartPosition + pageCount, currentCount);
            });
          }
        }
      });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefIndex, previousSearches);
  }

  void getPreviousSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefIndex)) {
      previousSearches = prefs.getStringList(prefIndex);
      if (previousSearches == null) {
        previousSearches = List<String>();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Search Card
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildSearchCard(),
          _buildRecipeLoader(context),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                String newValue = searchTextController.text;
                setState(() {
                  currentSearchList.clear();
                  currentCount = 0;
                  currentEndPosition = pageCount;
                  currentStartPosition = 0;
                  if (!previousSearches.contains(newValue)) {
                    previousSearches.add(newValue);
                    savePreviousSearches();
                  }
                });
              },
            ),
            SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        controller: searchTextController,
                        onChanged: (value) {
                        },
                      )),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      searchTextController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return previousSearches
                          .map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem(
                            child: Text(value), value: value);
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    return FutureBuilder<Response<Result<APIRecipeQuery>>>(
      future: RecipeService.create().queryRecipes(searchTextController.text.trim(),
          currentStartPosition, currentEndPosition),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          loading = false;
          final result = snapshot.data.body;
          // Hit an error
          if (result is Error) {
            inErrorState = true;
            return _buildRecipeList(context, currentSearchList);
          }
          final query = (result as Success).value;
          inErrorState = false;
          currentCount = query.count;
          hasMore = query.more;
          currentSearchList.addAll(query.hits);
          if (query.to < currentEndPosition) {
            currentEndPosition = query.to;
          }
          return _buildRecipeList(context, currentSearchList);
        } else {
          if (currentCount == 0) {
            // Show a loading indicator while waiting for the movies
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildRecipeList(context, currentSearchList);
          }
        }
      },
    );
  }

  Widget _buildRecipeList(BuildContext recipeListContext, List<APIHits> hits) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 220;
    final double itemWidth = size.width / 2;
    return Flexible(
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: hits.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRecipeCard(recipeListContext, hits, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext topLevelContext, List hits, int index) {
    APIRecipe recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return RecipeDetails();
          },
        ));
      },
      child: recipeCard(recipe),
    );
  }
}
