class FooderlichPathKey {
  static String splashPath = '/splash';
  static String loginPath = '/login';
  static String onboardingPath = '/onboarding';
  static String homePath = '/home';
  static String explore = '/explore';
  static String recipes = '/recipes';
  static String todo = '/todo';
}

class RouterConfiguration {
  RouterConfiguration(this.path, this.browserState);
  FooderlichRoutePath path;
  Map<String, dynamic> browserState;
}

class ExplorePathKey {
  static String friend = '/friend';
  static String exploreRecipe = '/recipe';
}

abstract class FooderlichRoutePath {
  const FooderlichRoutePath();
}

class SplashPath extends FooderlichRoutePath {
  const SplashPath();
}

class LoginPath extends FooderlichRoutePath {
  const LoginPath({this.username});
  final String username;
}

class OnboardingPath extends FooderlichRoutePath {
  const OnboardingPath();
}

class HomePath extends FooderlichRoutePath {
  const HomePath(this.tab);
  final int tab;
}

class ExplorePath extends FooderlichRoutePath {
  const ExplorePath();
}

class RecipesPath extends FooderlichRoutePath {
  const RecipesPath();
}

class TodoPath extends FooderlichRoutePath {
  const TodoPath(this.id);
  final String id;
}
