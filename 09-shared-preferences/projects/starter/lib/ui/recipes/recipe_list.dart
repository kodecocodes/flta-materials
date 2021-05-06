import 'dart:math';

import 'package:flutter/material.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key key}) : super(key: key);
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  TextEditingController searchTextController;
  final _scrollController = ScrollController();
  List currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
    _scrollController
      ..addListener(() {
        final triggerFetchMoreSize =
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
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            _buildRecipeLoader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            // Replace
            const Icon(Icons.search),
            const SizedBox(
              width: 6.0,
            ),
            // *** Start Replace
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Search'),
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
            // *** End Replace
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    // Show a loading indicator while waiting for the movies
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
