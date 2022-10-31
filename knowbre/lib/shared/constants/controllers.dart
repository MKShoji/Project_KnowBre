import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:knowbre/shared/services/auth_controller.dart';

AuthController authController = AuthController.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
DatabaseReference firebaseDatabase = FirebaseDatabase.instance.ref();
