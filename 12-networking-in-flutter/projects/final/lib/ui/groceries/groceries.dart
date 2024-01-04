import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/ingredient.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';
import '../widgets/ingredient_card.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  final checkBoxValues = <int, bool>{};
  late TextEditingController searchTextController;
  bool showAll = true;
  List<Ingredient> currentIngredients = [];
  bool searching = false;
  List<Ingredient> searchIngredients = [];
  final ScrollController _scrollController = ScrollController();
  final searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
    // TODO: Add Ingredient Stream
  }

  @override
  void dispose() {
    searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add Repository for ingredients
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          buildSearchRow(),
          showAll ? buildIngredientList() : buildNeedHaveList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 160.0,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: background1Color,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/background1.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNeedHaveList() {
    final needListIndexes = <int, bool>{};
    final haveListIndexes = <int, bool>{};
    final ingredients = currentIngredients;
    for (var index = 0; index < ingredients.length; index++) {
      if (!checkBoxValues.containsKey(index)) {
        needListIndexes[index] = true;
      } else {
        haveListIndexes[index] = true;
      }
    }
    final needList = <Ingredient>[];
    final haveList = <Ingredient>[];
    for (var index = 0; index < ingredients.length; index++) {
      if (needListIndexes.containsKey(index)) {
        needList.add(ingredients[index]);
      }
      if (haveListIndexes.containsKey(index)) {
        haveList.add(ingredients[index]);
      }
    }
    final columnList = <Widget>[];
    if (needList.isNotEmpty) {
      columnList.add(const Text('Need'));
      columnList.add(ingredientList(needList, null, false));
    }
    if (haveList.isNotEmpty) {
      columnList.add(const Text('Have'));
      columnList.add(ingredientList(haveList, null, false));
    }
    return Expanded(
      child: Column(
        children: columnList,
      ),
    );
  }

  Widget buildIngredientList() {
    if (searching) {
      startSearch(searchTextController.text);
      return ingredientList(searchIngredients, checkBoxValues, true);
    } else {
      return ingredientList(currentIngredients, checkBoxValues, true);
    }
  }

  Widget ingredientList(List<Ingredient> ingredients,
      Map<int, bool>? checkBoxValues, bool showCheckbox) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          final checked = checkBoxValues?[index] ?? false;
          return createIngredientCard(
              ingredients[index], checkBoxValues, checked, index, showCheckbox);
        },
      ),
    );
  }

  Widget createIngredientCard(
      Ingredient ingredient,
      Map<int, bool>? checkBoxValues,
      bool checked,
      int index,
      bool showCheckbox) {
    final even = index % 2 == 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IngredientCard(
          name: ingredient.name ?? '',
          initiallyChecked: checked,
          evenRow: even,
          showCheckbox: showCheckbox,
          onChecked: (newValue) {
            checkBoxValues?[index] = newValue;
          }),
    );
  }

  Widget buildSearchRow() {
    return Row(
      children: [
        sizedW8,
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            startSearch(searchTextController.text);
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
                  hintText: 'Search...',
                ),
                focusNode: searchFocusNode,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  startSearch(searchTextController.text);
                },
                controller: searchTextController,
              )),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              searching = false;
              searchTextController.text = '';
            });
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.filter_list,
          ),
          onSelected: (String value) {
            setState(() {
              showAll = value == 'All';
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              CheckedPopupMenuItem(
                value: 'All',
                checked: showAll,
                child: const Text('All'),
              ),
              CheckedPopupMenuItem(
                value: 'Need',
                checked: !showAll,
                child: const Text('Need/Have'),
              ),
            ];
          },
        ),
        sizedW8,
      ],
    );
  }

  void startSearch(String searchString) {
    searching = searchString.isNotEmpty;
    searchIngredients = currentIngredients
        .where((element) => true == element.name?.contains(searchString))
        .toList();
    setState(() {});
  }
}
