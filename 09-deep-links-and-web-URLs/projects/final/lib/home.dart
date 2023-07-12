import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/checkout_page.dart';
import 'package:yummy/components/category_thumbnail.dart';
import 'package:yummy/components/post_list.dart';
import 'package:yummy/constants.dart';
import 'package:yummy/models/user.dart';
import 'package:yummy/profile_screen.dart';

import 'components/restaurant_horizontal_list.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.tab});

  int tab;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.orange;
  ColorScheme? imageColorScheme = const ColorScheme.light();

  // int screenIndex = ScreenSelected.home.value;

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

  // void handleScreenChanged(int screenSelected) {
  //   setState(() {
  //     screenIndex = screenSelected;
  //   });
  // }

  static List<Widget> pages = <Widget>[
    ListView(scrollDirection: Axis.vertical, children: const [
      CategoryPage(),
      RestaurantsPage(),
      PostPage(),
    ]),
    Container(),
    Container(color: Colors.blue),
    ProfileScreen(
        user: User(
            firstName: 'Stef',
            lastName: 'P',
            role: 'Flutterisa',
            profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
            points: 100,
            darkMode: true))
  ];

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
      label: 'Activity',
      selectedIcon: Icon(Icons.format_paint),
    ),
    NavigationDestination(
      tooltip: '',
      icon: Icon(Icons.text_snippet_outlined),
      label: 'Payment',
      selectedIcon: Icon(Icons.text_snippet),
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
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Yummy'),
        leading: const BackButton(),
        // actions: actions,
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
          // setState(() {
          //   screenIndex = index;
          //   handleScreenChanged(screenIndex);
          // });
        },
        destinations: appBarDestinations,
      ),
      endDrawer: SizedBox(
        width: 375, // 75% of screen will be occupied
        child: Drawer(
          child: CheckoutPage()
        ),
      ),
    );
  }
}
