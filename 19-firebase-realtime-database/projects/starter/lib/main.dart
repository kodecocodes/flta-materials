import 'package:flutter/material.dart';
import 'ui/message_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Add Firebase Initialization
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Add MultiProvider
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RayChat',
      theme: ThemeData(primaryColor: const Color(0xFF3D814A)),
      // TODO: Add Consumer<UserDao> here
      home: const MessageList(),
      // TODO: Add closing parenthesis
    );
  }
}
