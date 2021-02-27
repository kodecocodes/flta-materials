import 'package:flutter/material.dart';
import 'package:fooderlich/navigation/fooderlich_route_path.dart';
import 'package:fooderlich/screens/onboarding_screen.dart';

class FooderlichInformationParser
    extends RouteInformationParser<RouterConfiguration> {
  @override
  Future<RouterConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final url = Uri.parse(routeInformation.location);
    var state = routeInformation.state as Map<String, dynamic>;
    state ??= <String, dynamic>{};

    if (url.path == FooderlichPathKey.homePath) {
      return RouterConfiguration(const HomePath(0), state);
    }

    if (url.path == FooderlichPathKey.onboardingPath) {
      return RouterConfiguration(const OnboardingPath(), state);
    }

    if (url.path == FooderlichPathKey.loginPath) {
      final username = url.queryParameters['username'] ?? '';
      return RouterConfiguration(LoginPath(username: username), state);
    }

    return RouterConfiguration(const SplashPath(), state);
  }

  @override
  RouteInformation restoreRouteInformation(RouterConfiguration configuration) {
    final path = configuration.path;

    if (path is SplashPath) {
      return RouteInformation(
          location: FooderlichPathKey.splashPath,
          state: configuration.browserState);
    }

    if (path is OnboardingPath) {
      return RouteInformation(location: FooderlichPathKey.onboardingPath);
    }

    if (path is LoginPath) {
      var location = FooderlichPathKey.loginPath;
      if (path.username != null && path.username.isNotEmpty) {
        location += '?username=${path.username}';
      }
      return RouteInformation(location: location);
    }

    if (path is HomePath) {
      return RouteInformation(
          location: FooderlichPathKey.homePath,
          state: configuration.browserState);
    }
    return null;
  }
}
