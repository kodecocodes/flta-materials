import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/user.dart';

typedef LogoutCallback = void Function(bool didLogout);

class ProfileScreen extends StatefulWidget {
  final User user;
  final LogoutCallback onLogOut;

  const ProfileScreen({
    super.key,
    required this.onLogOut,
    required this.user,
  });

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
        ListTile(
          title: const Text('View Kodeco'),
          onTap: () async {
            await launchUrl(Uri.parse('https://www.kodeco.com/'));
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            widget.onLogOut(true);
          },
        )
      ],
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60.0, // Adjust the radius to change the size of the avatar
          backgroundImage: AssetImage(widget.user.profileImageUrl),
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
        ),
      ],
    );
  }
}
