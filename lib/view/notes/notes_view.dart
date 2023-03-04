import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_basics/constants/routes.dart';
import 'package:new_basics/services/auth/auth_service.dart';
import 'package:new_basics/services/auth/bloc/auth_bloc.dart';
import 'package:new_basics/services/auth/bloc/auth_event.dart';
import 'package:new_basics/services/cloud/cloud_note.dart';
import 'package:new_basics/services/cloud/firebase_cloud_storage.dart';
import 'package:new_basics/view/notes/notes_list_view.dart';

import '../../enums/menu_action.dart';
import '../../utilities/dialogs/logout_dialog.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _notesService.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Notes'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    createUpdateNoteView,
                  );
                },
                icon: const Icon(Icons.add)),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    }
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text("logout"),
                  )
                ];
              },
            )
          ],
        ),
        body: //FutureBuilder(
            //   future: _notesService.getOrCreateUser(email: userEmail),
            //   builder: (context, snapshot) {
            //     switch (snapshot.connectionState) {
            //       case ConnectionState.done:
            StreamBuilder(
          stream: _notesService.allNotes(ownerUserId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allNotes = snapshot.data as Iterable<CloudNote>;
                  return NotesListView(
                    notes: allNotes,
                    onDeleteNote: (note) async {
                      await _notesService.deleteNote(
                          documentId: note.documentId);
                    },
                    onTap: (note) {
                      Navigator.of(context)
                          .pushNamed(createUpdateNoteView, arguments: note);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }

              default:
                return CircularProgressIndicator();
            }
          },
        )

        //       default:
        //         return CircularProgressIndicator();
        //     }
        //   },
        // ),
        );
  }
}

// Future<bool> showLogOutDialog(BuildContext context) {
//   return showDialog<bool>(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text("Sign out"),
//         content: Text("Are you sure you want to sign out?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             },
//             child: Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(true);
//             },
//             child: Text("Sign out"),
//           )
//         ],
//       );
//     },
//   ).then((value) => value ?? false);
// }
