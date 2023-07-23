import 'package:flutter/material.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({super.key});

  // Function to calculate number of columns
  int calculateColumnCount(double screenWidth) {
    int columns = 1;
    if (screenWidth > 700) {
      // Desktop
      columns = 2;
    }
    // Mobile will be default 1 column
    return columns;
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget orderSegmentedType() {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
            value: 0, label: Text('Delivery'), icon: Icon(Icons.pedal_bike)),
        ButtonSegment(
            value: 1, label: Text('Pickup'), icon: Icon(Icons.local_mall)),
      ],
      selected: const {0},
      onSelectionChanged: (Set newSelection) {
        print(newSelection);
      },
    );
  }

  Widget foodItem({
    required String title,
    required String description,
    required String price,
    required String imageUrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(price),
                    SizedBox(width: 4),
                    Icon(Icons.thumb_up, color: Colors.green, size: 18),
                  ],
                ),
              ],
            ),
            contentPadding: EdgeInsets.all(8.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                imageUrl,
                // width: 100,
                // height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget gridViewSection(double screenWidth, int columns, String title) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle(title),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 3.5,
                  crossAxisCount: columns,
                ),
                itemBuilder: (context, index) => foodItem(
                  title: "Burger",
                  description:
                      "A delicious beef burger with lettuce, tomato, and cheese.",
                  price: "\$5.99",
                  imageUrl:
                      "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1398&q=80",
                ),
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget restaurantStore(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double width70Percent = 2000 * 0.9;
    final columns = calculateColumnCount(screenWidth);
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 300.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 64.0),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16.0),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80'),
                              fit: BoxFit.cover)),
                    ),
                    const Positioned(
                      bottom:
                          0.0, // Half the size of the avatar to make it halfway overlapped.
                      left: 16.0,
                      child: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Cupbop', style: textTheme.headlineLarge),
              Text('3460 S 25th E, Idaho Falls, ID 83404, USA',
                  style: textTheme.bodySmall),
              Text('4.6 ★ 186 ratings · 0.4 mi · \$\$',
                  style: textTheme.bodySmall),
              Text('Poke, Healthy', style: textTheme.labelSmall),
              const SizedBox(height: 8.0),
              orderSegmentedType(),
            ]),
          ),
        ),
        gridViewSection(width70Percent, columns, 'Appetizers'),
        // gridViewSection(width70Percent, columns, 'Main Courses'),
        // gridViewSection(width70Percent, columns, 'Desserts'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      double maxWidth = 1000; // Set your max width here
      double width70Percent = constraints.maxWidth * 0.7;
      if (constraints.maxWidth > 1200) {
        return Center(
          child: SizedBox(
              width: width70Percent > maxWidth ? maxWidth : width70Percent,
              child: restaurantStore(context)),
        );
      } else {
        return restaurantStore(context);
      }
    }));
  }
}

  // Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(20),
  //                     image: const DecorationImage(
  //                       image:  NetworkImage(
  //                         'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80'), 
  //                         fit: BoxFit.cover)
  //                   ),
  //                 ),



// SliverAppBar(
//             expandedHeight: 100.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               centerTitle: true,
//               title: Text('Restaurant Name',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16.0,
//                   )),
              // background: Image.network(
              //   'https://source.unsplash.com/400x400/?restaurant',
              //   fit: BoxFit.cover,
              // ),
//             ),
//           ),