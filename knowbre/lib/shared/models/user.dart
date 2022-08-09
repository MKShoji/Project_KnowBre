import 'dart:convert';

class UserModel {
  final String uid;
  final String photoURL;
  final String email;
  final String name;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.photoURL});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      photoURL: map['photoURL'],
      uid: map['uid'],
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "email": email,
        "name": name,
        "photoURL": photoURL,
        "uid": uid,
      };
  String toJason() => jsonEncode(toMap());
}
