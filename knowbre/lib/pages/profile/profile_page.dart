// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../shared/services/auth_services.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final Future<User?> user = AuthServices().getCurrentUser();

//   // Widget _titlePage() {
//   //   return const Padding(
//   //     padding: EdgeInsets.only(
//   //       top: 10,
//   //       bottom: 10,
//   //       left: 16,
//   //       right: 16,
//   //     ),
//   //     child: Text(
//   //       "Meu perfil",
//   //       style: TextStyle(
//   //         fontSize: 26,
//   //         fontWeight: FontWeight.bold,
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget _titleUserName() {
//     return Padding(
//         padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
//         child: Text(
//           nome ?? 'User name',
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ));
//   }

//   Widget _textField(String labelText, String placeholder) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//       child: TextField(
//         decoration: InputDecoration(
//             enabled: false,
//             labelText: labelText,
//             labelStyle: const TextStyle(
//               color: Colors.blueAccent,
//               fontWeight: FontWeight.bold,
//             ),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: const TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             )),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Perfil'),
//       ),
//       body: SizedBox(
//         height: double.infinity,
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 25, bottom: 10),
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(user?.photoURL ?? ''),
//               ),
//             ),
//             _titleUserName(),
//             _textField("Nome", user?.displayName ?? 'User name'),
//             _textField("Email", user?.email ?? 'User email'),
//             _textField("Data de entrada", '${user?.metadata.creationTime}'),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
