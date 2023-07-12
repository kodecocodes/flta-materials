import 'package:flutter/material.dart';
import 'package:yummy/models/restaurant.dart';
import 'package:go_router/go_router.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Food near me',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8.0)),
                          child: AspectRatio(
                              aspectRatio: 2,
                              child: Image.asset(restaurants[index].imageUrl,
                                  fit: BoxFit.cover)),
                        ),
                        ListTile(
                          title: Text(restaurants[index].name,
                              style: textTheme.titleSmall),
                          subtitle: Text(restaurants[index].attributes,
                              maxLines: 1, style: textTheme.bodySmall),
                          onTap: () {
                            context.go('/store');
                          },
                        ),
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
