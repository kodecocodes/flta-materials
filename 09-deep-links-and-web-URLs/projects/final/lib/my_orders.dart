import 'package:flutter/material.dart';
import 'package:yummy/models/orders.dart';

class OrderPage extends StatelessWidget {
  final OrdersManager ordersManager;

  const OrderPage({super.key, required this.ordersManager});

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
        itemCount: ordersManager.totalOrders,
        itemBuilder: (context, index) {
          return OrderTile(order: ordersManager.orders[index]);
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          "assets/food/burger.webp",
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scheduled',
            style: textTheme.bodyLarge,
          ),
          Text(order.getFormattedOrderInfo()),
          Text('Items: ${order.items.length}'),
        ],
      ),
    );
  }
}
