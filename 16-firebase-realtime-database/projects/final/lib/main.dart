import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'ui/login.dart';
import 'ui/message_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDao = ref.watch(userDaoProvider);
    final currentScreen =
        userDao.isLoggedIn() ? const MessageList() : const Login();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kodeco Chat',
      theme: ThemeData(
        primaryColor: const Color(0xFF3D814A),
      ),
      home: currentScreen,
    );
  }
}
