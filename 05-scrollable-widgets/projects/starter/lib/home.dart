import 'package:flutter/material.dart';
import 'models/explore_recipe.dart';
import 'components/components.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    Card1(
        recipe: ExploreRecipe(
            authorName: 'Ray Wenderlich',
            title: 'The Art of Dough',
            subtitle: 'Editor\'s Choice',
            message: 'Learn to make the perfect bread.',
            backgroundImage: 'assets/magazine_pics/card_bread.jpg')),
    Card2(
        recipe: ExploreRecipe(
            authorName: 'Mike Katz',
            role: 'Smoothie Connoisseur',
            profileImage: 'assets/profile_pics/person_katz.jpeg',
            title: 'Recipe',
            subtitle: 'Smoothies',
            backgroundImage: 'assets/magazine_pics/mag2.png')),
    Card3(
        recipe: ExploreRecipe(
            title: 'Vegan Trends',
            tags: [
              'Healthy',
              'Vegan',
              'Carrots',
              'Greens',
              'Wheat',
              'Pescetarian',
              'Mint',
              'Lemongrass',
              'Salad',
              'Water'
            ],
            backgroundImage: 'assets/magazine_pics/mag3.png')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Fooderlich',
                style: Theme.of(context).textTheme.headline6)),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), label: 'Card'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), label: 'Card2'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), label: 'Card3'),
            ]));
  }
}
