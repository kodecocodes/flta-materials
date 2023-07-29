import 'package:flutter/material.dart';

class FoodOrder {
  final String imageUrl;
  final String status;
  final DateTime orderTime;
  final double price;
  final int itemCount;

  FoodOrder({
    required this.imageUrl,
    required this.status,
    required this.orderTime,
    required this.price,
    required this.itemCount,
  });
}

class OrderPage extends StatelessWidget {
  final List<FoodOrder> orders = [
    FoodOrder(
      imageUrl: 'https://example.com/image1.jpg',
      status: 'Preparing Food',
      orderTime: DateTime.now().subtract(Duration(hours: 2)),
      price: 50.0,
      itemCount: 5,
    ),
    FoodOrder(
      imageUrl: 'https://example.com/image1.jpg',
      status: 'Scheduled',
      orderTime: DateTime.now().subtract(Duration(hours: 2)),
      price: 50.0,
      itemCount: 5,
    ),
    FoodOrder(
      imageUrl: 'https://example.com/image1.jpg',
      status: 'Scheduled',
      orderTime: DateTime.now().subtract(Duration(hours: 2)),
      price: 50.0,
      itemCount: 5,
    ),
    FoodOrder(
      imageUrl: 'https://example.com/image1.jpg',
      status: 'Scheduled',
      orderTime: DateTime.now().subtract(Duration(hours: 2)),
      price: 50.0,
      itemCount: 5,
    ),
    FoodOrder(
      imageUrl: 'https://example.com/image1.jpg',
      status: 'Scheduled',
      orderTime: DateTime.now().subtract(Duration(hours: 2)),
      price: 50.0,
      itemCount: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('My Orders', style: textTheme.headlineMedium),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderTile(order: orders[index]);
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final FoodOrder order;

  OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80",
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${order.status}', 
            style: textTheme.headlineSmall,),
          Text('${order.orderTime.toString()}'),
          Text('\$${order.price.toStringAsFixed(2)}'),
          Text('Items: ${order.itemCount}'),
        ],
      ),
    );
  }
}
