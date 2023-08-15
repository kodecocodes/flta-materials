import 'package:flutter/material.dart';
import 'components/category_card.dart';
import 'components/post_card.dart';
import 'components/restaurant_landscape_card.dart';
import 'constants.dart';

import 'models/food_category.dart';
import 'models/post.dart';
import 'models/restaurant.dart';

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow = true;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}

class _ColorSeedButton extends StatelessWidget {
  const _ColorSeedButton({
    required this.handleColorSelect,
    required this.colorSelected,
  });

  final void Function(int) handleColorSelect;
  final ColorSeed colorSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.opacity_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Select a Seed Color',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          final currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor != colorSelected,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor == colorSelected
                        ? Icons.opacity_rounded
                        : Icons.opacity_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: handleColorSelect,
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
    required this.colorSelected,
  });

  final ColorSeed colorSelected;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.orange;
  ColorScheme? imageColorScheme = const ColorScheme.light();
  int tab = 0;

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      tooltip: '',
      icon: Icon(Icons.credit_card),
      label: 'Card',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      tooltip: '',
      icon: Icon(Icons.credit_card),
      label: 'Card2',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      tooltip: '',
      icon: Icon(Icons.credit_card),
      label: 'Card3',
      selectedIcon: Icon(Icons.credit_card),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      Center(child: CategoryCard(category: categories[0])),
      Center(child: PostCard(post: posts[0])),
      Center(child: RestaurantLandscapeCard(restaurant: restaurants[0]))
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          _BrightnessButton(
            handleBrightnessChange: widget.handleBrightnessChange,
          ),
          _ColorSeedButton(
            handleColorSelect: widget.handleColorSelect,
            colorSelected: widget.colorSelected,
          ),
        ],
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IndexedStack(index: tab, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: appBarDestinations,
      ),
    );
  }
}
