import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? photoURL;
  final String? email;
  final String? nome;
  final String? bio;
  final String? formacao;
  final String? apelido;
  final String? dataNasc;

  UserModel({
    required this.uid,
    required this.nome,
    required this.email,
    required this.photoURL,
    required this.apelido,
    required this.bio,
    required this.formacao,
    required this.dataNasc,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      email: data['email'],
      nome: data['nome'],
      photoURL: data['photoURL'],
      uid: data['uid'],
      formacao: data['formacao'],
      bio: data['bio'],
      apelido: data['apelido'],
      dataNasc: data['dataNasc'],
    );
  }
  Map<String, dynamic> toJson() => {
        "email": email,
        "nome": nome,
        "photoURL": photoURL,
        "uid": uid,
        "formacao": formacao,
        "bio": bio,
        "apelido": apelido,
        "dateNasc": dataNasc,
      };
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      nome: snapshot['nome'],
      photoURL: snapshot['photoURL'],
      apelido: snapshot['apelido'],
      bio: snapshot['bio'],
      dataNasc: snapshot['dataNasc'],
      formacao: snapshot['formacao'],
      uid: snapshot['uid'],
    );
  }
}
