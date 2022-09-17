import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/services/auth_controller.dart';

class DatabaseMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future addUserInfotoDB(String uid, UserModel userModel) {
    return firebaseFirestore
        .collection("users")
        .doc(uid)
        .set(userModel.toJson());
  }
}
