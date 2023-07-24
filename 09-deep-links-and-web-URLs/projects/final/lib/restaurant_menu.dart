import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/components/cart_control.dart';

import 'checkout_page.dart';
import 'models/shopping_cart.dart';
import 'package:uuid/uuid.dart';

class RestaurantMenu extends StatefulWidget {
  RestaurantMenu({super.key});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  final shoppingCart = ShoppingCart();

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
      onSelectionChanged: (Set newSelection) {},
    );
  }

  Widget foodItem({
    required String title,
    required String description,
    required String price,
    required String imageUrl,
    required BuildContext context,
  }) {
    final colorTheme = Theme.of(context).colorScheme;

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
        Stack(
          children: [
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
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                  decoration: BoxDecoration(
                    color: colorTheme
                        .onPrimary, // Specifying a color for the container
                    borderRadius:
                        BorderRadius.circular(16.0), // Rounded corners
                  ),
                  child: const Text('Add',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold))),
            ),
          ],
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
                padding: const EdgeInsets.all(0.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 3.5,
                  crossAxisCount: columns,
                  // mainAxisExtent: 120.0,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      // isDismissible: false,
                      showDragHandle: true,
                      context: context,
                      constraints: const BoxConstraints(maxWidth: 480),
                      builder: (context) {
                        return SizedBox(
                          width: 480,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: itemDetails(context),
                          ),
                        );
                      },
                    );
                  },
                  child: foodItem(
                    context: context,
                    title: "Burger",
                    description:
                        "A delicious beef burger with lettuce, tomato, and cheese.",
                    price: "\$5.99",
                    imageUrl:
                        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1398&q=80",
                  ),
                ),
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column itemDetails(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final colorTheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Text('B Bop Bowl', style: textTheme.headlineMedium),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: colorTheme.onPrimary,
                  child: const Text('#1 Most Liked')),
            ),
            const SizedBox(height: 16.0),
            const Text(
                'Korean style BBQ beef. Served with rice, cabbage mix, and noodle.'),
            const SizedBox(height: 16.0),
            Container(
              // width: 200, // Set width as desired
              height: 200, // Set height as desired
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    8.0), // This gives the rounded corners
                image: const DecorationImage(
                  image: AssetImage('assets/food/bopbowl.webp'),
                  fit: BoxFit
                      .cover, // This ensures the image covers the entire container
                ),
              ),
            )
          ],
        ),
        CartControl(
          addToCart: (number) {
            var uuid = const Uuid();
            String uniqueId = uuid.v4();
            final item = CartItem(
                id: uniqueId, 
                name: 'Bop Bowl', 
                price: 10.0, 
                quantity: number);
            setState(() {
              shoppingCart.addItem(item);
            });
            context.pop();
          },
        )
      ],
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
        gridViewSection(width70Percent, columns, 'Main Courses'),
        gridViewSection(width70Percent, columns, 'Desserts'),
        const SliverToBoxAdapter(
            child: SizedBox(
          height: 64.0,
        )),
      ],
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            openDrawer();
          },
          tooltip: 'Cart',
          icon: const Icon(Icons.shopping_cart),
          label: Text('${shoppingCart.items.length} Items in cart'),
        ),
        endDrawer: SizedBox(
          width: 375, // 75% of screen will be occupied
          child: Drawer(child: CheckoutPage(shoppingCart: shoppingCart,)),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          double maxWidth = 1000;
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
