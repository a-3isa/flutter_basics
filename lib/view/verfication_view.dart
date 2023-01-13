import 'package:flutter/material.dart';
import 'package:new_basics/constants/routes.dart';
import 'package:new_basics/services/auth/auth_service.dart';

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
              "We've sent you an email verfication. Please Verify Your Email",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   "Please Verify Your Email",
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            // ),
            TextButton(
                onPressed: () async {
                  AuthService.firebase().sendEmailVerfication();
                },
                child: Text(
                  "Didn't receive an email verification?! Send it again",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () async {
                  await AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
