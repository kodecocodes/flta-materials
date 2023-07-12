import 'package:flutter/material.dart';

import 'components/store_header.dart';

class RestaurantMenu extends StatelessWidget {
  int calculateColumnCount(double screenWidth) {
    if (screenWidth > 1200) {
      // Desktop
      return 3;
    } else if (screenWidth > 600) {
      // Tablet
      return 2;
    } else {
      // Mobile
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Restaurant Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  'https://source.unsplash.com/400x400/?restaurant',
                  fit: BoxFit.cover,
                )),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) => ListTile(
          //       title: Text('Opening time: 8am - 10pm'),
          //       subtitle: Text('Address: 123, XYZ Street, City, State'),
          //     ),
          //     childCount: 1,
          //   ),
          // ),

          SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        sliver:SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 3.0,
              crossAxisCount: calculateColumnCount(screenWidth),
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SizedBox(
                  height: 100, // Specify your height here
                  child: ListTile(
                    tileColor:  Colors.red,
                    title: Text('appetizers $index'),
                    subtitle: Text('appetizers $index'),
                  ),
                );
              },
              childCount: 10,
            ),
          )),
          SliverToBoxAdapter(child: SizedBox(height: 32),),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3.0,
                  crossAxisCount: calculateColumnCount(screenWidth),
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SizedBox(
                      height: 100, // Specify your height here
                      child: ListTile(
                        tileColor: Colors.red,
                        title: Text('appetizers $index'),
                        subtitle: Text('appetizers $index'),
                      ),
                    );
                  },
                  childCount: 10,
                ),
              )),
              SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3.0,
                  crossAxisCount: calculateColumnCount(screenWidth),
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SizedBox(
                      height: 100, // Specify your height here
                      child: ListTile(
                        tileColor: Colors.red,
                        title: Text('appetizers $index'),
                        subtitle: Text('appetizers $index'),
                      ),
                    );
                  },
                  childCount: 10,
                ),
              )),

          // SliverStickyHeader(
          //   header: Container(
          //     height: 60.0,
          //     color: Colors.lightBlue,
          //     padding: EdgeInsets.symmetric(horizontal: 16.0),
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       'Categories',
          //       style: const TextStyle(color: Colors.white),
          //     ),
          //   ),
          //   sliver: SliverList(
          //     delegate: SliverChildBuilderDelegate(
          //       (context, i) => ListTile(
          //         leading: Icon(Icons.fastfood),
          //         title: Text('Category $i'),
          //       ),
          //       childCount: 5,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
