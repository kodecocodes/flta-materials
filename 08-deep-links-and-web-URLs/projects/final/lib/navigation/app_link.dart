class AppLink {
  // 1
  static const String kHomePath = '/home';
  static const String kOnboardingPath = '/onboarding';
  static const String kLoginPath = '/login';
  static const String kProfilePath = '/profile';
  static const String kItemPath = '/item';
  // 2
  static const String kTabParam = 'tab';
  static const String kIdParam = 'id';
  // 3
  String? location;
  // 4
  int? currentTab;
  // 5
  String? itemId;
  // 6
  AppLink({
    this.location,
    this.currentTab,
    this.itemId,
  });

  static AppLink fromLocation(String? location) {
    // 1
    location = Uri.decodeFull(location ?? '');
    // 2
    final uri = Uri.parse(location);
    final params = uri.queryParameters;
    // 3
    final currentTab = int.tryParse(params[AppLink.kTabParam] ?? '');
    // 4
    final itemId = params[AppLink.kIdParam];
    // 5
    final link = AppLink(
      location: uri.path,
      currentTab: currentTab,
      itemId: itemId,
    );
    // 6
    return link;
  }

  String toLocation() {
    // 1
    String addKeyValPair({
      required String key,
      String? value,
    }) =>
        value == null ? '' : '${key}=$value&';
    // 2
    switch (location) {
      // 3
      case kLoginPath:
        return kLoginPath;
      // 4
      case kOnboardingPath:
        return kOnboardingPath;
      // 5
      case kProfilePath:
        return kProfilePath;
      // 6
      case kItemPath:
        var loc = '$kItemPath?';
        loc += addKeyValPair(
          key: kIdParam,
          value: itemId,
        );
        return Uri.encodeFull(loc);
      // 7
      default:
        var loc = '$kHomePath?';
        loc += addKeyValPair(
          key: kTabParam,
          value: currentTab.toString(),
        );
        return Uri.encodeFull(loc);
    }
  }
}
