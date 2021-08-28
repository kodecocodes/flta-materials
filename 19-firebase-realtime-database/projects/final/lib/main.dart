import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:raychat/ui/login.dart';
import 'data/user_dao.dart';
import 'ui/message_list.dart';
import '../data/message_dao.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDao>(
          lazy: false,
          create: (_) => UserDao(),
        ),
        Provider<MessageDao>(
          lazy: false,
          create: (_) => MessageDao(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RayChat',
        theme: ThemeData(primaryColor: Color(0xFF3D814A)),
        home: Consumer<UserDao>(
          builder: (context, userDao, child) {
            if (userDao.isLoggedIn()) {
              return MessageList();
            } else {
              return Login();
            }
          },
        ),
      ),
    );
  }
}
