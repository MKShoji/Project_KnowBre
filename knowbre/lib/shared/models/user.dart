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
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
        uid: doc['uid'],
        username: doc['username'],
        email: doc['email'],
        photoURL: doc['photoURL'],
        apelido: doc['apelido'],
        localizacao: doc['localizacao'],
        formacao: doc['formacao'],
        dataNasc: doc['dataNasc']);
  }
}
