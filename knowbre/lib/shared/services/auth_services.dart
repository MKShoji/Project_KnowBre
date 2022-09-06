import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knowbre/pages/home/home_page_controller.dart';
import 'package:knowbre/pages/login/login_page.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/services/auth_controller.dart';
import 'package:knowbre/shared/services/database.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthController authController = AuthController();

  User? get currentUser => _firebaseAuth.currentUser;

  Future signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String nome,
  ) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModel userModel = UserModel(
      apelido: '',
      bio: '',
      dataNasc: '',
      email: email,
      formacao: '',
      creationTime: _firebaseAuth.currentUser?.metadata.creationTime,
      nome: nome,
      photoURL: '',
      uid: _firebaseAuth.currentUser!.uid,
    );

    if (userCredential != null) {
      DatabaseMethods()
          .addUserInfotoDB(_firebaseAuth.currentUser!.uid, userModel);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    const SnackBar(content: Text('signOut'));
  }
}
