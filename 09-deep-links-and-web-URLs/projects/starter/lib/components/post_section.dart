import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';

class PostSection extends StatelessWidget {
  final List<Post> posts;
  const PostSection({super.key, required this.posts});

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
              'Friend\'s Activity',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 110.0,
            child: ListView.separated(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300.0,
                  child: PostCard(post: posts[index]));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            ),
          ),
        ],
      ),
    );
  }
}