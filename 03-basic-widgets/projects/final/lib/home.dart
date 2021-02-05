import 'package:flutter/material.dart';
import 'card1.dart';
import 'card2.dart';
import 'explore_card.dart';

// 1
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 7
  int _selectedIndex = 0;

  // 8
  static List<Widget> pages = <Widget>[
    Card1(),
    Card2(),
    Card3(),
  ];

  // 9
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Fooderlich",
                // 2
                style: Theme.of(context).textTheme.headline6)),
        body: pages[_selectedIndex],
        // 4
        bottomNavigationBar: BottomNavigationBar(
            // 5
            selectedItemColor: Theme.of(context).textSelectionColor,
            // 10
            currentIndex: _selectedIndex,
            // 11
            onTap: _onItemTapped,
            // 6
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), title: Text('Card')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), title: Text('Card2')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard), title: Text('Card3')),
            ]));
  }
}
