import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/cart_control.dart';
import '../models/cart_manager.dart';
import '../models/order_manager.dart';
import '../models/restaurant.dart';
import 'checkout_page.dart';
import 'restaurant_item.dart';

class RestaurantPage extends StatefulWidget {
  final Restaurant restaurant;
  final CartManager cartManager;
  final OrderManager ordersManager;

  const RestaurantPage(
      {super.key,
      required this.restaurant,
      required this.cartManager,
      required this.ordersManager});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const int desktopThreshold = 700;
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;
  static const double drawerWidth = 375.0;

  int calculateColumnCount(double screenWidth) {
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: _buildFloatingActionButton(),
      endDrawer: _buildEndDrawer(),
      body: _buildBody(constrainedWidth),
    );
  }

  // Floating action button to show cart
  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: openDrawer,
      tooltip: 'Cart',
      icon: const Icon(Icons.shopping_cart),
      label: Text('${widget.cartManager.items.length} Items in cart'),
    );
  }

// End drawer with a conditional width
  Widget _buildEndDrawer() {
    return SizedBox(
      width: drawerWidth,
      child: Drawer(
          child: CheckoutPage(
        cartManager: widget.cartManager,
        didUpdate: () {
          setState(() {});
        },
        onSubmit: (order) {
          widget.ordersManager.addOrder(order);
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      )),
    );
  }

// Body of the Scaffold
  Widget _buildBody(double constrainedWidth) {
    return Center(
      child: SizedBox(
        width: constrainedWidth,
        child: _buildCustomScrollView(),
      ),
    );
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  double _calculateConstrainedWidth(double screenWidth) {
    return (screenWidth > desktopThreshold
            ? screenWidth * largeScreenPercentage
            : screenWidth)
        .clamp(0.0, maxWidth);
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        _buildInfoSection(),
        _buildGridViewSection('Menu'),
        const SliverToBoxAdapter(child: SizedBox(height: 64.0)),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 64.0),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                          image: AssetImage(widget.restaurant.imageUrl),
                          fit: BoxFit.cover)),
                ),
                const Positioned(
                  bottom: 0.0,
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
    );
  }

  SliverToBoxAdapter _buildInfoSection() {
    final textTheme = Theme.of(context).textTheme;
    final restaurant = widget.restaurant;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurant.name, style: textTheme.headlineLarge),
            Text(restaurant.address, style: textTheme.bodySmall),
            Text(restaurant.getRatingAndDistance(), style: textTheme.bodySmall),
            Text(restaurant.attributes, style: textTheme.labelSmall),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildGridViewSection(String title) {
    final columns = calculateColumnCount(MediaQuery.of(context).size.width);
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(title),
            _buildGridView(columns),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  GridView _buildGridView(int columns) {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3.5,
        crossAxisCount: columns,
      ),
      itemBuilder: (context, index) => _buildGridItem(index),
      itemCount: widget.restaurant.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildGridItem(int index) {
    final item = widget.restaurant.items[index];
    return InkWell(
      onTap: () => _showBottomSheet(item),
      child: RestaurantItem(item: item),
    );
  }

  void _showBottomSheet(Item item) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(maxWidth: 480),
      builder: (context) => _itemDetails(item),
    );
  }

  Widget _itemDetails(Item item) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    final colorTheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              CartControl(
                addToCart: (number) {
                  const uuid = Uuid();
                  final uniqueId = uuid.v4();
                  final cartItem = CartItem(
                      id: uniqueId,
                      name: item.name,
                      price: item.price,
                      quantity: number);
                  setState(() {
                    widget.cartManager.addItem(cartItem);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
