import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/components/cart_control.dart';
import 'package:yummy/components/restaurant_item.dart';
import 'package:yummy/models/orders.dart';
import 'package:yummy/models/restaurant.dart';

import 'checkout_page.dart';
import 'constants.dart';
import 'models/shopping_cart.dart';
import 'package:uuid/uuid.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage(
      {super.key,
      required this.restaurant,
      required this.shoppingCart,
      required this.ordersManager});

  final Restaurant restaurant;
  final ShoppingCart shoppingCart;
  final OrdersManager ordersManager;

  @override
  createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const int desktopThreshold = 700;
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;

  int calculateColumnCount(double screenWidth) {
    int columns = 1;
    if (screenWidth > desktopThreshold) {
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
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
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
                    final item = widget.restaurant.items[index];
                    showModalBottomSheet<void>(
                      // isDismissible: false,
                      isScrollControlled: true,
                      showDragHandle: true,
                      context: context,
                      constraints: const BoxConstraints(maxWidth: 480),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: itemDetails(context, item),
                        );
                      },
                    );
                  },
                  child: RestaurantItem(item: widget.restaurant.items[index]),
                ),
                itemCount: widget.restaurant.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Wrap itemDetails(BuildContext context, Item item) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final colorTheme = Theme.of(context).colorScheme;

    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name, style: textTheme.headlineMedium),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: colorTheme.onPrimary,
                  child: const Text('#1 Most Liked')),
            ),
            const SizedBox(height: 16.0),
            Text(item.description),
            const SizedBox(height: 16.0),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    8.0), // This gives the rounded corners
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl),
                  fit: BoxFit
                      .cover, // This ensures the image covers the entire container
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            )
          ],
        ),
        CartControl(
          addToCart: (number) {
            var uuid = const Uuid();
            String uniqueId = uuid.v4();
            final cartItem = CartItem(
                id: uniqueId,
                name: item.name,
                price: item.price,
                quantity: number);
            setState(() {
              widget.shoppingCart.addItem(cartItem);
            });
            context.pop();
          },
        ),
      ],
    );
  }

  Widget restaurantStore(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double width70Percent = 2000 * 0.9;
    final restaurant = widget.restaurant;

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
                      margin: const EdgeInsets.only(bottom: 30.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                              image: AssetImage(restaurant.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    const Positioned(
                      bottom:
                          0.0, // Half the size of the avatar to make it halfway overlapped.
                      left: 16.0,
                      child: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.store, color: Colors.white),
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
              Text(restaurant.name, style: textTheme.headlineLarge),
              Text(restaurant.address, style: textTheme.bodySmall),
              Text(restaurant.getRatingAndDistance(),
                  style: textTheme.bodySmall),
              Text(restaurant.attributes, style: textTheme.labelSmall),
              const SizedBox(height: 8.0),
              // orderSegmentedType(),
            ]),
          ),
        ),
        gridViewSection(width70Percent, columns, 'Menu'),
        const SliverToBoxAdapter(
            child: SizedBox(
          height: 64.0,
        )),
      ],
    );
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width70Percent = screenWidth > desktopThreshold
        ? screenWidth * largeScreenPercentage
        : screenWidth;

    return Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: openDrawer,
          tooltip: 'Cart',
          icon: const Icon(Icons.shopping_cart),
          label: Text('${widget.shoppingCart.items.length} Items in cart'),
        ),
        endDrawer: SizedBox(
          width: 375,
          child: Drawer(
              child: CheckoutPage(
            shoppingCart: widget.shoppingCart,
            didUpdate: () {
              setState(() {});
            },
            onSubmit: (order) {
              widget.ordersManager.addOrder(order);
              context.pop();
              context.go('/?tab=${ScreenSelected.activity.value}');
            },
          )),
        ),
        body: Center(
          child: SizedBox(
              width: width70Percent > maxWidth ? maxWidth : width70Percent,
              child: restaurantStore(context)),
        ));
  }
}
