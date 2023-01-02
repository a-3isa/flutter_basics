import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Center(
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
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('Weak password');
                          } else if (e.code == 'email-is-already-in-use') {
                            print('Email is already in use');
                          } else if (e.code == 'invalid-email') {
                            print('Invalid email');
                          }
                        }
                      },
                      child: Text("Register"),
                    ),
                  ],
                ),
              );
            default:
              return Text("Loading");
          }
        },
      ),
    );
  }
}
