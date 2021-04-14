// import 'package:flutter/material.dart';
// import 'package:fooderlich/navigation/fooderlich_route_path.dart';
// import 'package:fooderlich/screens/onboarding_screen.dart';

import 'package:flutter/material.dart';

import 'app_link.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  // Take a url bar location, and create an AppLink from it
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    final link = AppLink.fromLocation(routeInformation.location);
    return link;
  }

  @override
  // Convert an applink into a string used for the browser location
  RouteInformation restoreRouteInformation(AppLink appLink) {
    print('restoreRouteInformation: ${appLink.location}');
    // Ask the applink to give us a string
    final location = appLink.toLocation();

    // Pass that string back to the OS so it can update the url bar
    return RouteInformation(location: location);
  }
}
