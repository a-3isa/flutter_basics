// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// Future<void> showErrorDialog(
//   BuildContext context,
//   String text,
// ) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('An Error occurred'),
//           content: Text(text),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Ok"))
//           ],
//         );
//       });
// }

// Future<void> showVerficationErrorDialog(
//   BuildContext context,
//   String text,
// ) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('You need to verify your email'),
//           content: Text(text),
//           actions: [
//             TextButton(
//                 onPressed: () async {
//                   final user = FirebaseAuth.instance.currentUser;
//                   await user?.sendEmailVerification();
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Send email verfication"))
//           ],
//         );
//       });
// }
