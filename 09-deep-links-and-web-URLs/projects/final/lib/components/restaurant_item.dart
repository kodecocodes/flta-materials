import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class RestaurantItem extends StatelessWidget {
  final Item item;

  const RestaurantItem({
    super.key,
    required this.item,
  });

  Widget _buildListItem() {
    return ListTile(
      title: Text(item.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${item.price}'),
              const SizedBox(width: 4),
              const Icon(Icons.thumb_up, color: Colors.green, size: 18),
            ],
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(8.0),
    );
  }

  Widget _buildImageStack(ColorScheme colorScheme) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          right: 8.0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: const Text(
              'Add',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildListItem()),
        _buildImageStack(colorScheme),
      ],
    );
  }
}
