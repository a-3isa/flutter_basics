import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_basics/constants/routes.dart';
import 'package:new_basics/services/auth/auth_service.dart';
import 'package:new_basics/services/auth/bloc/auth_bloc.dart';
import 'package:new_basics/services/auth/bloc/auth_event.dart';

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
            const Text(
              "We've sent you an email verfication. Please Verify Your Email",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   "Please Verify Your Email",
            //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            // ),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSendEmailVerfication(),
                      );
                },
                child: const Text(
                  "Didn't receive an email verification?! Send it again",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
