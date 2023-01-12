import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_basics/constants/routes.dart';
import 'package:new_basics/view/logout_view.dart';
import 'firebase_options.dart';
import 'view/login_view.dart';
import 'view/register_view.dart';
import 'view/verfication_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => LoginView(),
      registerRoute: (context) => RegisterView(),
      verficationRoute: (context) => VerficationView(),
      logoutRoute: (context) => LogoutView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              // log(user?.email as);
              if (user != null) {
                if (user.emailVerified) {
                  return LogoutView();
                } else {
                  return VerficationView();
                }
              } else {
                return LoginView();
              }

            default:
              return Center(child: CircularProgressIndicator());
          }
        });
  }
}
