import 'package:flutter/material.dart';
import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mockService.getExploreData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(scrollDirection: Axis.vertical, children: [
              TodayRecipeListView(recipes: snapshot.data.todayRecipes),
              SizedBox(height: 16),
              FriendPostListView(friendPosts: snapshot.data.friendPosts)
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
