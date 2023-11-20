import 'package:flutter/material.dart';
import '../models/models.dart';

class CategoryCard extends StatelessWidget {
  final FoodCategory category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Image.asset(category.imageUrl),
              ),
            ],
          ),
          ListTile(
              title: Text(category.name, style: textTheme.titleSmall),
              subtitle: Text('${category.numberOfRestaurants} places',
                  style: textTheme.bodySmall)),
        ],
      ),
    );
  }
}
