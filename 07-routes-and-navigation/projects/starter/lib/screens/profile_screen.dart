import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/circle_image.dart';
import '../models/models.dart';

class ProfileScreen extends StatefulWidget {
  // TODO: ProfileScreen MaterialPage Helper

  final User user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // TODO: Close Profile Screen
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        buildDarkModeRow(),
        ListTile(
          title: const Text('View raywenderlich.com'),
          onTap: () {
            // TODO: Open raywenderlich.com webview
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            // TODO: Logout user
          },
        )
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileManager>(context, listen: false).darkMode =
                  value;
            },
          )
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.user.firstName,
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Text(widget.user.role),
        Text(
          '${widget.user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
