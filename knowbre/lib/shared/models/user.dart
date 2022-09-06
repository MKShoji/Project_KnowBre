import 'dart:convert';

class UserModel {
  final String uid;
  final String? photoURL;
  final String email;
  final String nome;
  final DateTime? creationTime;
  final String bio;
  final String formacao;
  final String apelido;
  final String dataNasc;

  UserModel({
    required this.uid,
    required this.nome,
    required this.email,
    required this.photoURL,
    required this.apelido,
    required this.creationTime,
    required this.bio,
    required this.formacao,
    required this.dataNasc,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      nome: map['name'],
      photoURL: map['photoURL'],
      uid: map['uid'],
      creationTime: map['creationTime'],
      formacao: map['formacao'],
      bio: map['bio'],
      apelido: map['apelido'],
      dataNasc: map['dataNasc'],
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": nome,
        "photoURL": photoURL,
        "uid": uid,
        "idade": creationTime,
        "formacao": formacao,
        "bio": bio,
        "apelido": apelido,
        "date": dataNasc,
      };
  String toJason() => jsonEncode(toJson());
}
