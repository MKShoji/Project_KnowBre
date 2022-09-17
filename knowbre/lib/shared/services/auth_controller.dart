import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/home/home_page_controller.dart';
import 'package:knowbre/pages/login/welcome_page.dart';
import 'package:knowbre/shared/models/user.dart' as model;
import 'package:knowbre/shared/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Rxn<User?> _user = Rxn<User?>();
  Rxn<model.UserModel> firestoreUser = Rxn<model.UserModel>();

  User? get user => _user.value;

  @override
  void onReady() async {
    super.onReady();
    _user = Rxn<User?>(_firebaseAuth.currentUser);
    _user.bindStream(_firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      getUser.then(
        (value) => user,
      );
    }

    if (user == null) {
      Get.offAll(() => const WelcomePage());
    } else {
      Get.offAll(() => const HomePageController());
    }
  }

  Future<User?> get getUser async => _firebaseAuth.currentUser;

  Stream<model.UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return DatabaseMethods()
        .firebaseFirestore
        .doc('/users/${_user.value!.uid}')
        .snapshots()
        .map((snapshot) => model.UserModel.fromMap(snapshot.data()!));
  }

  Future<model.UserModel> getFirestoreUser() {
    return DatabaseMethods()
        .firebaseFirestore
        .doc('/users/${user!.uid}')
        .get()
        .then((documentSnapshot) =>
            model.UserModel.fromMap(documentSnapshot.data()!));
  }

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

    model.UserModel userModel = model.UserModel(
      apelido: '',
      bio: '',
      dataNasc: '',
      email: email,
      formacao: '',
      nome: nome,
      photoURL: '',
      uid: userCredential.user!.uid,
    );

    if (userCredential != null) {
      DatabaseMethods().addUserInfotoDB(userCredential.user!.uid, userModel);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
