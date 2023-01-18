import 'package:flutter/material.dart';
import 'package:new_basics/constants/routes.dart';
import 'package:new_basics/view/notes/create_update_note_view.dart';
import 'package:new_basics/view/notes/notes_view.dart';
import 'view/login_view.dart';
import 'view/register_view.dart';
import 'view/verfication_view.dart';
import 'package:new_basics/services/auth/auth_service.dart';

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
      notesRoute: (context) => NotesView(),
      newNoteRoute: (context) => NewNoteView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              // log(user?.email as);
              if (user != null) {
                if (user.isEmailVerified) {
                  return NotesView();
                } else {
                  return LoginView();
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
