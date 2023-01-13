import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_basics/constants/routes.dart';
import 'package:new_basics/services/auth/auth_exceptions.dart';
import 'package:new_basics/services/auth/auth_service.dart';
import 'package:new_basics/utilities/show_error.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();

  // @override
  // void initState() {
  //   _email = TextEditingController();
  //   _password = TextEditingController();
  //   super.initState();
  // }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(hintText: "Email"),
              enableSuggestions: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  final userCredential =
                      await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerfication();
                  Navigator.of(context).pushNamed(
                    verficationRoute,
                  );
                } on WeakPasswordException {
                  await showErrorDialog(
                    context,
                    'Weak password',
                  );
                } on EmailAlreadyInUseException {
                  await showErrorDialog(
                    context,
                    'Email is already in use',
                  );
                } on InvalidEmailException {
                  await showErrorDialog(
                    context,
                    'Invalid email',
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'Failed to register',
                  );
                }
              },
              child: Text("Register"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: Text("Already registerd? Login here!"),
            )
          ],
        ),
      ),
    );
  }
}
