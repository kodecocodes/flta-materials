import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/category_card.dart';
import 'components/color_button.dart';
import 'components/message_list.dart';
import 'components/restaurant_landscape_card.dart';
import 'components/theme_button.dart';
import 'constants.dart';
import 'models/food_category.dart';
import 'models/restaurant.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
    required this.appTitle,
  });

  final ColorSelection colorSelected;
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final String appTitle;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  int tab = 1; // To change default card to Category change to 0

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: Add userDaoProvider

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        elevation: 4.0,
        backgroundColor: theme.colorScheme.background,
        shadowColor: theme.shadowColor,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
          // TODO: Replace with logout button
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: CategoryCard(category: categories[0]),
            ),
          ),
          // TODO: Remove const below
          const Center(
            // TODO: Add Login
            child: MessageList(),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: RestaurantLandscapeCard(restaurant: restaurants[0]),
            ),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.credit_card),
            label: 'Category',
            selectedIcon: Icon(Icons.credit_card),
          ),
          NavigationDestination(
            icon: Icon(Icons.question_answer),
            label: 'Chat',
            selectedIcon: Icon(Icons.question_answer),
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card),
            label: 'Restaurant',
            selectedIcon: Icon(Icons.credit_card),
          )
        ],
      ),
    );
  }
}
