import 'package:flutter/material.dart';
import '../models/food_category.dart';


class CategoryPage extends StatelessWidget {

  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0, bottom: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Categories',
                  style: textTheme.headlineMedium
                ),
                Text('See All', style: textTheme.bodyLarge)
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 200,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8.0)),
                          child: Image.asset(categories[index].imageUrl),
                        ),
                        ListTile(
                          title: Text(
                            categories[index].name, 
                            style: textTheme.titleSmall),
                          subtitle: Text(
                            '${categories[index].numberOfRestaurants} places', 
                              style: textTheme.bodySmall),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
