class AppLink {
  static const String kHomePath = '/home';
  static const String kOnboardingPath = '/onboarding';
  static const String kLoginPath = '/login';
  static const String kProfilePath = '/profile';
  static const String kItem = '/item';

  static const String kTabParam = 'tab';
  static const String kIdParam = 'id';

  String location;
  int currentTab;
  String itemId;

  AppLink({this.location, this.currentTab, this.itemId});

  static AppLink fromLocation(String location) {
    print('fromLocation: $location');

    location = Uri.decodeFull(location);
    // Shared function to inject keys if they are not null
    final uri = Uri.parse(location);
    final params = uri.queryParameters;
    location = uri.path;

    print('path: ${uri.path}');
    print('params ${params.toString()}');

    void trySet(String key, void Function(String) setter) {
      if (params.containsKey(key)) setter?.call(params[key]);
    }

    // Create the applink, inject any params we've found
    final link = AppLink()..location = location;
    trySet(AppLink.kTabParam, (s) => link.currentTab = int.tryParse(s));
    trySet(AppLink.kIdParam, (s) => link.itemId = s);
    return link;
  }

  String toLocation() {
    String addKeyValPair({String key, String value}) =>
        value == null ? '' : '${key}=$value&';

    if (location == kOnboardingPath) {
      return '$kOnboardingPath';
    } else if (location == kLoginPath) {
      return '$kLoginPath?';
    } else if (location == kProfilePath) {
      return '$kProfilePath';
    } else if (location == kItem) {
      var loc = '$kItem?';
      loc += addKeyValPair(key: kIdParam, value: itemId);
      return Uri.encodeFull(loc);
    } else {
      var loc = '$kHomePath?';
      loc += addKeyValPair(key: kTabParam, value: currentTab.toString());
      return Uri.encodeFull(loc);
    }
  }
}
