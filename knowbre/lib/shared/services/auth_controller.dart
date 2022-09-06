import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowbre/pages/home/home_page_controller.dart';
import 'package:knowbre/pages/login/welcome_page.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/services/auth_services.dart';
import 'package:knowbre/shared/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onReady() async {
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
    }
    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(() => const WelcomePage());
    } else {
      Get.offAll(() => const HomePageController());
    }
  }

  Future<User> get getUser async => _firebaseAuth.currentUser!;

  Stream<User?> get user => _firebaseAuth.authStateChanges();

  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/users/${firebaseUser.value?.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }
}
