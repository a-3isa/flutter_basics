import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutView extends StatefulWidget {
  const LogoutView({super.key});

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulation'),
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20,
                ),
              ))
        ],
      )),
    );
  }
}
