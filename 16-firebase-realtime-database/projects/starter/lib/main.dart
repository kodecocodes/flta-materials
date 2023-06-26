import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/message_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Add Firebase Initialization
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Add userDaoProvider
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kodeco Chat',
      theme: ThemeData(primaryColor: const Color(0xFF3D814A)),
      // TODO: Replace with current screen here
      home: const MessageList(),
      
    );
  }
}
