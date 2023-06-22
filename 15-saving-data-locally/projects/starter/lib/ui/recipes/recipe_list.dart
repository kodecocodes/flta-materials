import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/ui/widgets/common.dart';

import '../../data/models/models.dart';
import '../../network/model_response.dart';
import '../../network/query_result.dart';
import '../../network/service_interface.dart';
import '../../providers.dart';
import '../myrecipes/my_recipes_list.dart';
import '../recipe_card.dart';
import '../recipes/recipe_details.dart';
import '../theme/colors.dart';
import '../widgets/custom_dropdown.dart';

enum ListType { all, bookmarks }

class RecipeList extends ConsumerStatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _RecipeListState();
}

class _RecipeListState extends ConsumerState<RecipeList> {
  static const String prefSearchKey = 'previousSearches';

  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();
  List<Recipe> currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;
  List<String> previousSearches = <String>[];
  ListType currentType = ListType.all;
  Future<RecipeResponse>? currentResponse;
  bool newDataRequired = true;

  @override
  void initState() {
    super.initState();
    getPreviousSearches();

    searchTextController = TextEditingController(text: '');
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore &&
            currentEndPosition < currentCount &&
            !loading &&
            !inErrorState) {
          setState(
            () {
              loading = true;
              newDataRequired = true;
              currentStartPosition = currentEndPosition;
              currentEndPosition =
                  min(currentStartPosition + pageCount, currentCount);
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    final prefs = ref.read(sharedPrefProvider);
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = ref.read(sharedPrefProvider);
    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);
      if (searches != null) {
        previousSearches = searches;
      } else {
        previousSearches = <String>[];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (currentType) {
      ListType.all => buildRecipeList(),
      ListType.bookmarks => buildBookmarkList()
    };
  }

  Widget buildRecipeList() {
    return Container(
      color: Colors.white,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
          physics: const ClampingScrollPhysics(),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: topPadding8 + horizontalPadding8,
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeader(),
                    _buildTypePicker(),
                    _buildSearchCard(),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: allPadding8,
              sliver: _buildRecipeLoader(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBookmarkList() {
    return Padding(
      padding: allPadding8,
      child: Column(
        children: <Widget>[
          _buildTypePicker(),
          const MyRecipesList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 160.0,
      width: 200,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: lightGreen,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/background2.png',
                fit: BoxFit.cover,
              ),
            ),
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
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            sizedW8,
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      startSearch(searchTextController.text);
                    },
                    controller: searchTextController,
                  )),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: lightGrey,
                    ),
                    onSelected: (String value) {
                      searchTextController.text = value;
                      startSearch(searchTextController.text);
                    },
                    itemBuilder: (BuildContext context) {
                      return previousSearches
                          .map<CustomDropdownMenuItem<String>>((String value) {
                        return CustomDropdownMenuItem<String>(
                          text: value,
                          value: value,
                          callback: () {
                            setState(() {
                              previousSearches.remove(value);
                              savePreviousSearches();
                              Navigator.pop(context);
                            });
                          },
                        );
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

  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      newDataRequired = true;
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = false;
      value = value.trim();
      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

  Sliver _buildRecipeLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return emptySliverWidget;
    }
    return FutureBuilder<RecipeResponse>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SliverFillRemaining(
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                ),
              ),
            );
          }

          loading = false;
          // Hit an error
          if (false == snapshot.data?.isSuccessful) {
            var errorMessage = 'Problems getting data';
            if (snapshot.data?.error != null &&
                snapshot.data?.error is LinkedHashMap) {
              final map = snapshot.data?.error as LinkedHashMap;
              errorMessage = map['message'];
            }
            return SliverFillRemaining(
              child: Center(
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            );
          }
          final result = snapshot.data?.body;
          if (result == null || result is Error) {
            inErrorState = true;
            return _buildRecipeList(context, currentSearchList);
          }
          final query = (result as Success).value as QueryResult;
          inErrorState = false;
          currentCount = query.totalResults;
          hasMore = query.totalResults > (query.offset + query.number);
          currentSearchList.addAll(query.recipes);
          currentEndPosition =
              min(query.totalResults, currentEndPosition + query.number);
          return _buildRecipeList(context, currentSearchList);
        } else {
          if (currentCount == 0) {
            // Show a loading indicator while waiting for the movies
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return _buildRecipeList(context, currentSearchList);
          }
        }
      },
    );
  }

  Future<RecipeResponse> fetchData() async {
    if (!newDataRequired && currentResponse != null) {
      return currentResponse!;
    }
    newDataRequired = false;
    final recipeService = ref.watch(serviceProvider);
    currentResponse = recipeService.queryRecipes(
        searchTextController.text.trim(), currentStartPosition, pageCount);
    return currentResponse!;
  }

  Widget _buildRecipeList(
      BuildContext recipeListContext, List<Recipe> recipes) {
    return SliverLayoutBuilder(
      builder: (BuildContext context, SliverConstraints constraints) {
        final numColumns = max(1, constraints.crossAxisExtent ~/ 264);
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: recipes.length,
            (BuildContext context, int index) {
              return _buildRecipeCard(
                recipeListContext,
                recipes,
                index,
              );
            },
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numColumns, mainAxisExtent: 264),
        );
      },
    );
  }

  Widget _buildRecipeCard(
    BuildContext topLevelContext,
    List<Recipe> recipes,
    int index,
  ) {
    final recipe = recipes[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(topLevelContext, MaterialPageRoute(
          builder: (context) {
            final detailRecipe = Recipe(
              id: recipe.id,
              label: recipe.label,
              image: recipe.image,
              ingredients: const <Ingredient>[],
            );
            return RecipeDetails(recipe: detailRecipe);
          },
        ));
      },
      child: recipeCard(recipe),
    );
  }

  Widget _buildTypePicker() {
    return IntrinsicWidth(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton<ListType>(
              segments: const [
                ButtonSegment<ListType>(
                    value: ListType.all, label: Text('All'), enabled: true),
                ButtonSegment<ListType>(
                    value: ListType.bookmarks,
                    label: Text('Bookmarks'),
                    enabled: true),
              ],
              selected: {currentType},
              onSelectionChanged: (Set<ListType> newSelection) {
                setState(() {
                  // By default there is only a single segment that can be
                  // selected at one time, so its value is always the first
                  // item in the selected set.
                  currentType = newSelection.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
