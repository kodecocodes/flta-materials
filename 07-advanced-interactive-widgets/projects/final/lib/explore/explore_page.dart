import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import '../models/order_manager.dart';
import 'category_section.dart';
import 'post_section.dart';
import 'restaurant_section.dart';


class ExplorePage extends StatelessWidget {
  const ExplorePage({
    super.key,
    required this.cartManager,
    required this.orderManager});

  final CartManager cartManager;
  final OrderManager orderManager;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        RestaurantSection(
          cartManager: cartManager,
          orderManager: orderManager,
        ),
        const CategorySection(),
        const PostSection(),
      ]);
  }
}
