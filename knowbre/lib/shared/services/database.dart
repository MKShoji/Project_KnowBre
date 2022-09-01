import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knowbre/shared/models/user.dart';
import 'package:knowbre/shared/services/auth_services.dart';

class DatabaseMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future addUserInfotoDB(String uid, UserModel userModel) {
    return firebaseFirestore
        .collection("users")
        .doc(uid)
        .set(userModel.toJson());
  }

  Future updateUserInfotoDB(String uid, UserModel userModel) {
    return firebaseFirestore
        .collection("users")
        .doc(uid)
        .update(userModel.toJson());
  }

  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return firebaseFirestore
        .doc("users")
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  Future<UserModel> getUserfromDB(String uid) {
    return firebaseFirestore.collection("users").doc(uid).get().then(
        (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }
}
