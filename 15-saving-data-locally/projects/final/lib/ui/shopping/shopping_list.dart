import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes/providers.dart';

import '../../data/models/ingredient.dart';
import '../theme/colors.dart';
import '../widgets/common.dart';
import '../widgets/ingredient_card.dart';

class ShoppingList extends ConsumerStatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  ConsumerState<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends ConsumerState<ShoppingList> {
  final checkBoxValues = <int, bool>{};
  late TextEditingController searchTextController;
  bool showAll = true;
  List<Ingredient> currentIngredients = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    searchTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    for (var index = 0; index < currentIngredients.length; index++) {
      if (!checkBoxValues.containsKey(index)) {
        needListIndexes[index] = true;
      } else {
        haveListIndexes[index] = true;
      }
    }
    final needList = <Ingredient>[];
    final haveList = <Ingredient>[];
    for (var index = 0; index < currentIngredients.length; index++) {
      if (needListIndexes.containsKey(index)) {
        needList.add(currentIngredients[index]);
      }
      if (haveListIndexes.containsKey(index)) {
        haveList.add(currentIngredients[index]);
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
    final repository = ref.read(repositoryProvider);
    return StreamBuilder(
      stream: repository.watchAllIngredients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final ingredients = snapshot.data;
          if (ingredients == null) {
            currentIngredients = [];
            return Container();
          }
          currentIngredients = ingredients;
          return ingredientList(currentIngredients, checkBoxValues, true);
        } else {
          return Container();
        }
      },
    );
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
                  hintText: 'Search...',
                ),
                autofocus: false,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  startSearch(searchTextController.text);
                },
                controller: searchTextController,
              )),
            ],
          ),
        ),
        sizedW8,
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
    final index = currentIngredients
        .indexWhere((element) => true == element.name?.contains(searchString));
    if (index != -1) {
      _scrollController.animateTo(index * 50,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }
}
