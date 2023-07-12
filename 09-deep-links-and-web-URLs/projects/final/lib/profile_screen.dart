import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
// import '../components/circle_image.dart';
// import '../models/models.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/user.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({
    super.key,
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
        buildDarkModeRow(),
        ListTile(
          title: const Text('View Kodeco'),
          onTap: () async {
            // if (kIsWeb || Platform.isMacOS) {
              await launchUrl(Uri.parse('https://www.kodeco.com/'));
            // } else {
            //   // context.goNamed(
            //   //   'rw',
            //   //   params: {
            //   //     'tab': '${widget.currentTab}',
            //   //   },
            //   // );
            // }
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () {
            // Provider.of<AppStateManager>(context, listen: false).logout();
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
              // Provider.of<ProfileManager>(context, listen: false).darkMode =
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
