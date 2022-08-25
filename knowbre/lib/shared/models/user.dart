import 'dart:convert';

class UserModel {
  final String uid;
  final String photoURL;
  final String email;
  final String nome;
  final String idade;
  final String bio;
  final String formacao;
  final String apelido;
  final String date;

  UserModel({
    required this.uid,
    required this.nome,
    required this.email,
    required this.photoURL,
    required this.apelido,
    required this.idade,
    required this.bio,
    required this.formacao,
    required this.date,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      nome: map['name'],
      photoURL: map['photoURL'],
      uid: map['uid'],
      idade: map['idade'],
      formacao: map['formacao'],
      bio: map['bio'],
      apelido: map['apelido'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": nome,
        "photoURL": photoURL,
        "uid": uid,
        "idade": idade,
        "formacao": formacao,
        "bio": bio,
        "apelido": apelido,
        "date": date,
      };
}
