// import 'package:flutter/material.dart';

// void main() {
//   runApp(BooksApp());
// }

// class Book {
//   final String title;
//   final String author;

//   Book(this.title, this.author);
// }

// class BooksApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _BooksAppState();
// }

// class _BooksAppState extends State<BooksApp> {
//   BookRouterDelegate _routerDelegate = BookRouterDelegate();
//   BookRouteInformationParser _routeInformationParser =
//       BookRouteInformationParser();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Books App',
//       routerDelegate: _routerDelegate,
//       routeInformationParser: _routeInformationParser,
//     );
//   }
// }

// class BookRouteInformationParser extends RouteInformationParser<BookRoutePa
//th> {
//   @override
//   Future<BookRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location);

//     if (uri.pathSegments.length >= 2) {
//       var remaining = uri.pathSegments[1];
//       return BookRoutePath.details(int.tryParse(remaining));
//     } else {
//       return BookRoutePath.home();
//     }
//   }

//   @override
//   RouteInformation restoreRouteInformation(BookRoutePath path) {
//     if (path.isHomePage) {
//       return RouteInformation(location: '/');
//     }
//     if (path.isDetailsPage) {
//       return RouteInformation(location: '/book/${path.id}');
//     }
//     return null;
//   }
// }

// class BookRouterDelegate extends RouterDelegate<BookRoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
//   final GlobalKey<NavigatorState> navigatorKey;

//   Book _selectedBook;

//   List<Book> books = [
//     Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
//     Book('Foundation', 'Isaac Asimov'),
//     Book('Fahrenheit 451', 'Ray Bradbury'),
//   ];

//   BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

//   BookRoutePath get currentConfiguration => _selectedBook == null
//       ? BookRoutePath.home()
//       : BookRoutePath.details(books.indexOf(_selectedBook));

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       transitionDelegate: NoAnimationTransitionDelegate(),
//       pages: [
//         MaterialPage(
//           key: ValueKey('BooksListPage'),
//           child: BooksListScreen(
//             books: books,
//             onTapped: _handleBookTapped,
//           ),
//         ),
//         if (_selectedBook != null) BookDetailsPage(book: _selectedBook)
//       ],
//       onPopPage: (route, result) {
//         if (!route.didPop(result)) {
//           return false;
//         }

//         // Update the list of pages by setting _selectedBook to null
//         _selectedBook = null;
//         notifyListeners();

//         return true;
//       },
//     );
//   }

//   @override
//   Future<void> setNewRoutePath(BookRoutePath path) async {
//     if (path.isDetailsPage) {
//       _selectedBook = books[path.id];
//     }
//   }

//   void _handleBookTapped(Book book) {
//     _selectedBook = book;
//     notifyListeners();
//   }
// }

// class BookDetailsPage extends Page {
//   final Book book;

//   BookDetailsPage({
//     this.book,
//   }) : super(key: ValueKey(book));

//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute(
//       settings: this,
//       builder: (BuildContext context) {
//         return BookDetailsScreen(book: book);
//       },
//     );
//   }
// }

// class BookRoutePath {
//   final int id;

//   BookRoutePath.home() : id = null;

//   BookRoutePath.details(this.id);

//   bool get isHomePage => id == null;

//   bool get isDetailsPage => id != null;
// }

// class BooksListScreen extends StatelessWidget {
//   final List<Book> books;
//   final ValueChanged<Book> onTapped;

//   BooksListScreen({
//     @required this.books,
//     @required this.onTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         children: [
//           for (var book in books)
//             ListTile(
//               title: Text(book.title),
//               subtitle: Text(book.author),
//               onTap: () => onTapped(book),
//             )
//         ],
//       ),
//     );
//   }
// }

// class BookDetailsScreen extends StatelessWidget {
//   final Book book;

//   BookDetailsScreen({
//     @required this.book,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (book != null) ...[
//               Text(book.title, style: Theme.of(context).textTheme.headline6),
//               Text(book.author, style: Theme.of(context).textTheme.subtitle1)
//,
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
//   @override
//   Iterable<RouteTransitionRecord> resolve({
//     List<RouteTransitionRecord> newPageRouteHistory,
//     Map<RouteTransitionRecord, RouteTransitionRecord>
//         locationToExitingPageRoute,
//     Map<RouteTransitionRecord, List<RouteTransitionRecord>>
//         pageRouteToPagelessRoutes,
//   }) {
//     final results = <RouteTransitionRecord>[];

//     for (final pageRoute in newPageRouteHistory) {
//       if (pageRoute.isWaitingForEnteringDecision) {
//         pageRoute.markForAdd();
//       }
//       results.add(pageRoute);
//     }

//     for (final exitingPageRoute in locationToExitingPageRoute.values) {
//       if (exitingPageRoute.isWaitingForExitingDecision) {
//         exitingPageRoute.markForRemove();
//         final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
//         if (pagelessRoutes != null) {
//           for (final pagelessRoute in pagelessRoutes) {
//             pagelessRoute.markForRemove();
//           }
//         }
//       }

//       results.add(exitingPageRoute);
//     }
//     return results;
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooderlich/navigation/fooderlich_information_parser.dart';
import 'package:fooderlich/navigation/fooderlich_route_path.dart';
import 'package:fooderlich/navigation/fooderlich_router_delegate.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';
import 'package:uni_links/uni_links.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'fooderlich_theme.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';
import 'home.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key key}) : super(key: key);

  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final _appStateManager = AppStateManager();
  final _routeInformationParser = FooderlichInformationParser();
  FooderlichRouterDelegate _routerDelegate;
  StreamSubscription _linkSubscription;

  @override
  void initState() {
    super.initState();
    _routerDelegate = FooderlichRouterDelegate(_appStateManager);
    initPlatformState();
  }

  @override
  void dispose() {
    if (_linkSubscription != null) _linkSubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Attach a listener to the Uri links stream
    _linkSubscription = getUriLinksStream().listen((Uri uri) async {
      final routeInformation = RouteInformation(location: uri.toString());
        final routerConfig = await _routeInformationParser
            .parseRouteInformation(routeInformation);
      if (!mounted) return;
      setState(() {
        print(uri);
        // xcrun simctl openurl booted fooderlich://open/onboarding
        _routerDelegate
            .setNewRoutePath(routerConfig);
      });
    }, onError: (Object err) {
      print('Got error $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _appStateManager,
          ),
          ChangeNotifierProvider(
            create: (context) => GroceryManager(),
          )
        ],
        child: MaterialApp.router(
            theme: theme,
            routeInformationParser: _routeInformationParser,
            routerDelegate: _routerDelegate));
  }
}

/*
Consumer<AppStateManager>(
    builder: (context, stateManager, child) {
  return Navigator(
      pages: [
        SplashScreen.page(),
        if (stateManager.isInitialized) LoginScreen.page(),
        if (stateManager.isLoggedIn) OnboardingScreen.page(),
        if (stateManager.isOnboardingComplete) Home.page(),
        if (stateManager.selectedGroceryItem != null)
          GroceryItemScreen.page(
              item: stateManager.selectedGroceryItem,
              onUpdate: (item) {
                Provider.of<GroceryManager>(context, listen: false)
                    .updateItem(item, stateManager.groceryItemIndex);
                Provider.of<AppStateManager>(
                  context, 
                  listen: false).popItem();
              })
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        Provider.of<AppStateManager>(
          context, 
          listen: false).popItem();

        return true;
      });
})

*/
