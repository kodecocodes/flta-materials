import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // TODO: LoginScreen MaterialPage Helper

  final String? username;

  const LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage(
                    'assets/fooderlich_assets/rw_logo.png',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildTextfield(username ?? '🍔 username'),
              const SizedBox(height: 16),
              buildTextfield('🎹 password'),
              const SizedBox(height: 16),
              buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: rwColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          // TODO: Login -> Navigate to home
        },
      ),
    );
  }

  Widget buildTextfield(String hintText) {
    return TextField(
      cursorColor: rwColor,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }
}
