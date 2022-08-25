import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/services/auth_services.dart';

class DatabaseMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future addUserInfotoDB(String uid, Map<String, dynamic> userModel) {
    return firebaseFirestore.collection("users").doc(uid).set(userModel);
  }

  Future<DocumentSnapshot> getUserfromDB(String uid) {
    return firebaseFirestore.collection("users").doc(uid).get();
  }
}
