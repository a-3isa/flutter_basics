// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_basics/constants/routes.dart';
// import 'package:new_basics/view/notes/create_update_note_view.dart';
// import 'package:new_basics/view/notes/notes_view.dart';
// import 'view/login_view.dart';
// import 'view/register_view.dart';
// import 'view/verfication_view.dart';
// import 'package:new_basics/services/auth/auth_service.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MaterialApp(
//     title: 'Flutter Demo',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: const HomePage(),
//     routes: {
//       loginRoute: (context) => const LoginView(),
//       registerRoute: (context) => const RegisterView(),
//       verficationRoute: (context) => const VerficationView(),
//       notesRoute: (context) => const NotesView(),
//       createUpdateNoteView: (context) => const CreateUpdateNoteView()
//     },
//   ));
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: AuthService.firebase().initialize(),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               final user = AuthService.firebase().currentUser;
//               // log(user?.email as);
//               if (user != null) {
//                 if (user.isEmailVerified) {
//                   return const NotesView();
//                 } else {
//                   return const LoginView();
//                 }
//               } else {
//                 return const LoginView();
//               }

//             default:
//               return const Center(child: CircularProgressIndicator());
//           }
//         });
//   }
// }

// // class Counter extends StatefulWidget {
// //   const Counter({super.key});

// //   @override
// //   State<Counter> createState() => _CounterState();
// // }

// // class _CounterState extends State<Counter> {
// //   late final TextEditingController _controller;

// //   @override
// //   void initState() {
// //     _controller = TextEditingController();
// //     super.initState();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => CounterBloc(),
// //       child: Scaffold(
// //           appBar: AppBar(
// //             title: const Text("Testing Bloc"),
// //           ),
// //           body: BlocConsumer<CounterBloc, CounterState>(
// //             listener: (context, state) {
// //               _controller.clear();
// //             },
// //             builder: (context, state) {
// //               final invalidValue =
// //                   (state is CounterStateInvalid) ? state.invalidValue : "";
// //               return Column(
// //                 children: [
// //                   Text("Current value => ${state.value}"),
// //                   Visibility(
// //                     child: Text("Invalid Input $invalidValue"),
// //                     visible: state is CounterStateInvalid,
// //                   ),
// //                   TextField(
// //                     controller: _controller,
// //                     decoration: const InputDecoration(hintText: 'Enter number'),
// //                     keyboardType: TextInputType.number,
// //                   ),
// //                   Row(
// //                     children: [
// //                       TextButton(
// //                           onPressed: () {
// //                             context
// //                                 .read<CounterBloc>()
// //                                 .add(DecrementEvent(_controller.text));
// //                           },
// //                           child: const Text('-')),
// //                       TextButton(
// //                           onPressed: () {
// //                             context
// //                                 .read<CounterBloc>()
// //                                 .add(IncrementEvent(_controller.text));
// //                           },
// //                           child: const Text('+')),
// //                     ],
// //                   )
// //                 ],
// //               );
// //             },
// //           )),
// //     );
// //   }
// // }

// // @immutable
// // abstract class CounterState {
// //   final int value;

// //   const CounterState(this.value);
// // }

// // class CounterStateValid extends CounterState {
// //   const CounterStateValid(int value) : super(value);
// // }

// // class CounterStateInvalid extends CounterState {
// //   final String invalidValue;
// //   CounterStateInvalid({
// //     required this.invalidValue,
// //     required int previousValue,
// //   }) : super(previousValue);
// // }

// // abstract class CounterEvent {
// //   final String value;

// //   CounterEvent(this.value);
// // }

// // class IncrementEvent extends CounterEvent {
// //   IncrementEvent(String value) : super(value);
// // }

// // class DecrementEvent extends CounterEvent {
// //   DecrementEvent(String value) : super(value);
// // }

// // class CounterBloc extends Bloc<CounterEvent, CounterState> {
// //   CounterBloc() : super(const CounterStateValid(0)) {
// //     on<IncrementEvent>((event, emit) {
// //       final integer = int.tryParse(event.value);
// //       if (integer != null) {
// //         emit(CounterStateValid(state.value + integer));
// //       } else {
// //         emit(CounterStateInvalid(
// //             invalidValue: event.value, previousValue: state.value));
// //       }
// //     });
// //     on<DecrementEvent>((event, emit) {
// //       final integer = int.tryParse(event.value);
// //       if (integer != null) {
// //         emit(CounterStateValid(state.value - integer));
// //       } else {
// //         emit(CounterStateInvalid(
// //             invalidValue: event.value, previousValue: state.value));
// //       }
// //     });
// //   }
// // }
