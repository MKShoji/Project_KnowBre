// import 'package:flutter/material.dart';
// import 'package:knowbre/shared/constants/controllers.dart';
// import 'package:knowbre/shared/models/post.dart';

// class PostWidget extends StatefulWidget {
//   final Post? post;
//   const PostWidget({Key? key, this.post}) : super(key: key);

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   int likeCount = 1;
//   Widget buildPostHeader() {
//     return FutureBuilder(
//         future: firebaseFirestore
//             .collection("posts")
//             .doc(widget.post?.ownerId)
//             .get(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(
//                   authController.firestoreUser.value?.photoURL ?? ''),
//               backgroundColor: Colors.grey,
//             ),
//             title: GestureDetector(
//               onTap: () {},
//               child: Text(
//                 authController.firestoreUser.value?.username ?? 'Usuário',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//             ),
//             subtitle: Text(widget.post?.title ?? 'Título'),
//             trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
//           );
//         });
//   }

//   Widget buildPostImage() {
//     return GestureDetector(
//       onDoubleTap: () {},
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Image.network(widget.post?.mediaUrl ?? ''),
//         ],
//       ),
//     );
//   }

//   Widget buildPostFooter() {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(top: 40.0, left: 20.0),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Icon(Icons.favorite, size: 28.0, color: Colors.pink),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 20.0),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child:
//                   Icon(Icons.star_border, size: 28.0, color: Colors.blue[900]),
//             ),
//           ],
//           mainAxisAlignment: MainAxisAlignment.start,
//         ),
//         Row(
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(left: 20.0),
//               child: Text(
//                 '$likeCount likes',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//             )
//           ],
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(left: 20.0),
//               child: Text(
//                 '${widget.post?.username}',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               child: Text(widget.post?.description ?? 'Descricao'),
//             )
//           ],
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         buildPostHeader(),
//         buildPostImage(),
//         buildPostFooter(),
//       ],
//     );
//   }
// }
