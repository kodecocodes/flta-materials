import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 700) {
            // Display Desktop View
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      'assets/login_background.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Expanded(
                  child: FractionallySizedBox(
                      widthFactor: 0.70, child: LoginForm()),
                ),
              ],
            );
          } else {
            // Display Mobile View
            return const Column(
              children: [
                Expanded(
                  child: LoginForm(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/yummy_logo.png',
            height: 150,
            width: 150,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              // filled: true,
              hintText: 'Username',
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(8.0), // Rounded corner border
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              // filled: true,
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(8.0), // Rounded corner border
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            child: const Text('Login'),
            onPressed: () {
              context.go('/?tab=0');
            },
          ),
        ],
      ),
    );
  }
}
