import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerficationView extends StatefulWidget {
  const VerficationView({super.key});

  @override
  State<VerficationView> createState() => _VerficationViewState();
}

class _VerficationViewState extends State<VerficationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verfication"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please Verify Your Email",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: Text(
                  "Send email verification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
