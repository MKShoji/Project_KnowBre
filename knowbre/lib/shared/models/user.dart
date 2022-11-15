import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? photoURL;
  final String? email;
  final String? username;
  final String? localizacao;
  final String? formacao;
  final String? apelido;
  final String? dataNasc;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.photoURL,
    required this.apelido,
    required this.localizacao,
    required this.formacao,
    required this.dataNasc,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      email: data['email'],
      username: data['username'],
      photoURL: data['photoURL'],
      uid: data['uid'],
      formacao: data['formacao'],
      localizacao: data['localizacao'],
      apelido: data['apelido'],
      dataNasc: data['dataNasc'],
    );
  }
  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "photoURL": photoURL,
        "uid": uid,
        "formacao": formacao,
        "bio": localizacao,
        "apelido": apelido,
        "dateNasc": dataNasc,
      };
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      username: snapshot['username'],
      photoURL: snapshot['photoURL'],
      apelido: snapshot['apelido'],
      localizacao: snapshot['localizacao'],
      dataNasc: snapshot['dataNasc'],
      formacao: snapshot['formacao'],
      uid: snapshot['uid'],
    );
  }
}
