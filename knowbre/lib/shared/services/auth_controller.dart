import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:flutter/material.dart';
import 'package:knowbre/shared/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCrontroller {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> get getUser async => AuthServices().currentUser;
  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
