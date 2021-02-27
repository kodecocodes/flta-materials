import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  // TODO: Remember to talk about why keys are important
  // Similar to element Keys replacing items in a list.
  // Without a unique key, the framework can't determine
  // which transition animation to show between different pages
  static MaterialPage page() {
    return MaterialPage(
        key: ValueKey(FooderlichPages.splashPath), child: const SplashScreen());
  }

  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Timer(const Duration(milliseconds: 2000), () {
    //   Provider.of<AppStateManager>(
    //     context, 
    //     listen: false).initializeApp();      
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
        ),
      ),
    );
  }
}
