import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class Login extends ConsumerStatefulWidget {
  const Login({
    super.key,
  });

  @override
  ConsumerState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  // 1
  final _emailController = TextEditingController();
  // 2
  final _passwordController = TextEditingController();
  // 3
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // 4
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1
    final userDao = ref.watch(userDaoProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        // 2
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                // 1
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Email Address',
                  ),
                  autofocus: false,
                  // 2
                  keyboardType: TextInputType.emailAddress,
                  // 3
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  // 4
                  controller: _emailController,
                  // 5
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email Required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Password',
                  ),
                  autofocus: false,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  controller: _passwordController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Required';
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // 1
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final errorMessage = await userDao.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                      // 2
                      if (errorMessage != null) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            duration: const Duration(milliseconds: 700),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // 3
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final errorMessage = await userDao.signup(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (errorMessage != null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(milliseconds: 700),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
