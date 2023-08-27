import 'package:flutter/material.dart';

import '../components/restaurant_landscape_card.dart';
import '../models/cart_manager.dart';
import '../models/order_manager.dart';
import '../models/restaurant.dart';
import '../restaurant/restaurant_page.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({
    super.key,
    required this.cartManager,
    required this.orderManager});


  final CartManager cartManager;
  final OrderManager orderManager;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Food near me',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return SizedBox(
                    width: 300,
                    child: RestaurantLandscapeCard(
                      restaurant: restaurant,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantPage(
                              restaurant: restaurant,
                              cartManager: cartManager,
                              ordersManager: orderManager,
                            )),
                        );
                      },
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
