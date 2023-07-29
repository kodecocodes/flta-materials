import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/checkout_page.dart';
import 'package:yummy/components/category_thumbnail.dart';
import 'package:yummy/components/post_list.dart';
import 'package:yummy/constants.dart';
import 'package:yummy/models/shopping_cart.dart';
import 'package:yummy/models/user.dart';
import 'package:yummy/my_orders.dart';
import 'package:yummy/profile.dart';

import 'components/restaurant_horizontal_list.dart';
import 'models/auth.dart';

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
          ColorSeed currentColor = ColorSeed.values[index];

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
    required this.auth,
    required this.shoppingCart,
    required this.tab,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
    required this.colorSelected,
  });

  final int tab;
  final ColorSeed colorSelected;
  final YummyAuth auth;
  final ShoppingCart shoppingCart;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.orange;
  ColorScheme? imageColorScheme = const ColorScheme.light();

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
      icon: Icon(Icons.widgets_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      tooltip: '',
      icon: Icon(Icons.format_paint_outlined),
      label: 'Orders',
      selectedIcon: Icon(Icons.format_paint),
    ),
    NavigationDestination(
      tooltip: '',
      icon: Icon(Icons.invert_colors_on_outlined),
      label: 'Account',
      selectedIcon: Icon(Icons.opacity),
    )
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ListView(
        scrollDirection: Axis.vertical, 
        children: const [
        CategoryPage(),
        RestaurantsPage(),
        PostPage(),
      ]),
      OrderPage(),
      ProfileScreen(
          onLogOut: (logout) async {
            widget.auth.signOut().then((value) => context.go('/login'));
          },
          user: User(
              firstName: 'Stef',
              lastName: 'P',
              role: 'Flutterisa',
              profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
              points: 100,
              darkMode: true))
    ];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        // title: const Text('Yummy'),
        // leading: const BackButton(),
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
      body: LayoutBuilder(builder: (context, constraints) {
        double maxWidth = 1000; // Set your max width here
        double width70Percent = constraints.maxWidth * 0.7;
        if (constraints.maxWidth > 1200) {
          return Center(
            child: SizedBox(
                width: width70Percent > maxWidth ? maxWidth : width70Percent,
                child: IndexedStack(index: widget.tab, children: pages)),
          );
        } else {
          return IndexedStack(index: widget.tab, children: pages);
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDrawer();
        },
        tooltip: 'Cart',
        child: const Icon(Icons.shopping_cart_outlined),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.tab,
        onDestinationSelected: (index) {
          context.go('/?tab=$index');
        },
        destinations: appBarDestinations,
      ),
      endDrawer: SizedBox(
        width: 375, // 75% of screen will be occupied
        child: Drawer(
            child: CheckoutPage(
              shoppingCart: widget.shoppingCart, 
              didUpdate: () { 
                setState(() {});
              },
        )),
      ),
    );
  }
}
