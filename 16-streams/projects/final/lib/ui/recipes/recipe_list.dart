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
import 'dart:convert';
import 'dart:math';

import 'package:provider/provider.dart';
import 'package:recipes/data/models/recipe.dart';
import 'package:recipes/data/repository.dart';
import 'package:recipes/mock_service/mock_service.dart';
import 'package:chopper/chopper.dart';
import 'package:recipes/network/model_response.dart';
import 'package:recipes/ui/recipe_card.dart';
import 'package:recipes/ui/recipes/recipe_details.dart';
import 'package:recipes/network/recipe_model.dart';
import 'package:flutter/material.dart';

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
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
  APIRecipeQuery currentQuery;

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

  @override
  Widget build(BuildContext context) {
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
            Icon(Icons.search),
            SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(border: UnderlineInputBorder()),
                autofocus: false,
                controller: searchTextController,
                onChanged: (query) => {
                  if (query.length >= 3)
                    {
                      // Rebuild list
                      setState(() {
                        currentSearchList.clear();
                        currentCount = 0;
                        currentEndPosition = pageCount;
                        currentStartPosition = 0;
                      })
                    }
                },
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
    var repository = Provider.of<Repository>(context);
    return FutureBuilder<Response<Result<APIRecipeQuery>>>(
      future: Provider.of<MockService>(context).queryRecipes(searchTextController.text.trim(),
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
            return _buildRecipeList(context, currentSearchList, repository);
          }
          final query = (result as Success).value;
          inErrorState = false;
          currentCount = query.count;
          hasMore = query.more;
          currentSearchList.addAll(query.hits);
          if (query.to < currentEndPosition) {
            currentEndPosition = query.to;
          }
          return _buildRecipeList(context, currentSearchList, repository);
        } else {
          if (currentCount == 0) {
            // Show a loading indicator while waiting for the movies
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildRecipeList(context, currentSearchList, repository);
          }
        }
      },
    );
  }

  Widget _buildRecipeList(BuildContext recipeListContext, List<APIHits> hits, Repository repository) {
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
          return _buildRecipeCard(recipeListContext, hits, index, repository);
        },
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext topLevelContext, List<APIHits> hits, int index, Repository repository) {
    APIRecipe recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            var detailRecipe = Recipe(
                label: recipe.label, image: recipe.image, url: recipe.url);
            detailRecipe.ingredients = convertIngredients(recipe.ingredients);
            return RecipeDetails(
                repository, detailRecipe);
          },
        ));
      },
      child: recipeCard(recipe),
    );
  }
}
