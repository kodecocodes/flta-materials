import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers.dart';
import '../utils.dart';
import 'groceries/groceries.dart';
import 'theme/colors.dart';

import 'recipes/recipe_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  List<Widget> pageList = <Widget>[];
  static const String prefSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pageList.add(const RecipeList());
    pageList.add(const GroceryList());
    getCurrentIndex();
  }

  void saveCurrentIndex() async {
    final prefs = ref.read(sharedPrefProvider);
    final bottomNavigation = ref.read(bottomNavigationProvider);
    prefs.setInt(prefSelectedIndexKey, bottomNavigation.selectedIndex);
  }

  void getCurrentIndex() async {
    final prefs = ref.read(sharedPrefProvider);
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        final index = prefs.getInt(prefSelectedIndexKey);
        if (index != null) {
          ref
              .read(bottomNavigationProvider.notifier)
              .updateSelectedIndex(index);
        }
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      ref.read(bottomNavigationProvider.notifier).updateSelectedIndex(index);
    });
    saveCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    if (isDesktop() || isWeb()) {
      return largeLayout();
    } else {
      return mobileLayout();
    }
  }

  Widget largeLayout() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final selectedColor =
        isDarkMode ? darkBackgroundColor : smallCardBackgroundColor;
    return AdaptiveLayout(
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('PrimaryNavigation'),
            builder: (_) {
              return Container(
                decoration: BoxDecoration(color: selectedColor),
                child: AdaptiveScaffold.standardNavigationRail(
                  destinations: getRailNavigations(),
                  onDestinationSelected: (int index) {
                    _onItemTapped(index);
                  },
                  labelType: NavigationRailLabelType.all,
                  selectedIndex:
                      ref.read(bottomNavigationProvider).selectedIndex,
                  backgroundColor: selectedColor,
                  selectedIconTheme: IconTheme.of(context)
                      .copyWith(color: iconBackgroundColor),
                  unselectedIconTheme:
                      IconTheme.of(context).copyWith(color: Colors.black),
                ),
              );
            },
          )
        },
      ),
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig?>{
          Breakpoints.standard: SlotLayout.from(
            key: const Key('body'),
            builder: (_) {
              return Container(
                color: Colors.white,
                child: IndexedStack(
                  index: ref.read(bottomNavigationProvider).selectedIndex,
                  children: pageList,
                ),
              );
            },
          ),
        },
      ),
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig?>{
          Breakpoints.small: SlotLayout.from(
              key: const Key('bottomNavigation'),
              builder: (_) => createBottomNavigationBar())
        },
      ),
    );
  }

  List<NavigationRailDestination> getRailNavigations() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = isDarkMode ? Colors.white : Colors.black;
    return [
      NavigationRailDestination(
        icon: SvgPicture.asset(
          'assets/images/icon_recipe.svg',
          colorFilter: ColorFilter.mode(
              ref.read(bottomNavigationProvider).selectedIndex == 0
                  ? selectedColor
                  : Colors.black,
              BlendMode.srcIn),
          semanticsLabel: 'Recipes',
        ),
        label: const Text(
          'Recipes',
          style: TextStyle(fontSize: 10),
        ),
      ),
      NavigationRailDestination(
        icon: SvgPicture.asset(
          'assets/images/shopping_cart.svg',
          colorFilter: ColorFilter.mode(
              ref.read(bottomNavigationProvider).selectedIndex == 0
                  ? selectedColor
                  : Colors.black,
              BlendMode.srcIn),
          semanticsLabel: 'Groceries',
        ),
        label: const Text(
          'Groceries',
          style: TextStyle(fontSize: 10),
        ),
      ),
    ];
  }

  Widget mobileLayout() {
    return Scaffold(
      bottomNavigationBar: createBottomNavigationBar(),
      body: SafeArea(
        child: IndexedStack(
          index: ref.read(bottomNavigationProvider).selectedIndex,
          children: pageList,
        ),
      ),
    );
  }

  BottomNavigationBar createBottomNavigationBar() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = isDarkMode ? Colors.white : Colors.black;
    final unSelectedItemColor = isDarkMode ? Colors.white : Colors.grey;
    final backgroundColor =
        isDarkMode ? darkBackgroundColor : smallCardBackgroundColor;
    final bottomNavigationIndex =
        ref.read(bottomNavigationProvider).selectedIndex;
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      currentIndex: bottomNavigationIndex,
      selectedItemColor: selectedColor,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/icon_recipe.svg',
            colorFilter: ColorFilter.mode(
                bottomNavigationIndex == 0
                    ? selectedColor
                    : unSelectedItemColor,
                BlendMode.srcIn),
            semanticsLabel: 'Recipes',
          ),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          backgroundColor:
              bottomNavigationIndex == 1 ? iconBackgroundColor : Colors.black,
          icon: SvgPicture.asset(
            'assets/images/shopping_cart.svg',
            colorFilter: ColorFilter.mode(
                bottomNavigationIndex == 1
                    ? selectedColor
                    : unSelectedItemColor,
                BlendMode.srcIn),
            semanticsLabel: 'Groceries',
          ),
          label: 'Groceries',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
