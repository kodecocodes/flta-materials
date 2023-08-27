import 'package:flutter/material.dart';

import 'category_section.dart';
import 'post_section.dart';
import 'restaurant_section.dart';


class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: const [
        RestaurantSection(),
        CategorySection(),
        PostSection(),
      ]);
  }
}
