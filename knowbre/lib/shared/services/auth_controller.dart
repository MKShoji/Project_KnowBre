import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knowbre/pages/home/home_page_controller.dart';
import 'package:knowbre/pages/login/welcome_page.dart';
import 'package:knowbre/shared/constants/controllers.dart';
import 'package:knowbre/shared/models/user.dart' as model;
import 'package:knowbre/shared/services/database.dart';
import 'package:knowbre/shared/themes/app_colors.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Rxn<User?> _user = Rxn<User?>();
  Rxn<model.UserModel> firestoreUser = Rxn<model.UserModel>();

  User? get user => _user.value;

  @override
  void onReady() async {
    super.onReady();
    _user = Rxn<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
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
      Get.offAll(
        () => const WelcomePage(),
        transition: Transition.rightToLeft,
      );
    } else {
      Get.offAll(() => const HomePageController(),
          transition: Transition.native);
    }
  }

  Future<User?> get getUser async => firebaseAuth.currentUser;

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

  getUserId() async {
    final currentUser = firebaseAuth.currentUser;
    DocumentSnapshot doc =
        await firebaseFirestore.collection("users").doc(currentUser!.uid).get();
  }

  Future signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Get.snackbar(
        "Login",
        "Usuário conectado!",
        icon: Icon(Icons.check_circle_outline, color: AppColor.primary),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.snackBarBackground,
        colorText: AppColor.background,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Erro",
          "Nenhum usuário econtrado",
          animationDuration: Duration(seconds: 1),
          backgroundColor: AppColor.snackBarBackground,
          colorText: AppColor.background,
          icon: Icon(Icons.error_outline, color: AppColor.primary),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.GROUNDED,
          reverseAnimationCurve: Curves.bounceIn,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Erro",
          "Email ou Senha incorretos",
          animationDuration: Duration(seconds: 1),
          backgroundColor: AppColor.snackBarBackground,
          colorText: AppColor.background,
          icon: Icon(Icons.error_outline, color: AppColor.primary),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.GROUNDED,
          reverseAnimationCurve: Curves.bounceIn,
        );
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String nome,
  ) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    model.UserModel userModel = model.UserModel(
      apelido: '',
      localizacao: '',
      dataNasc: '',
      email: email,
      formacao: '',
      username: nome,
      photoURL: '',
      uid: userCredential.user!.uid,
    );

    if (userCredential != null) {
      DatabaseMethods().addUserInfotoDB(userCredential.user!.uid, userModel);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
          title: 'Enviado!',
          middleText: 'Enviado a notificação para a redefinição da senha');
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Email não castrado",
        animationDuration: Duration(seconds: 1),
        backgroundColor: AppColor.snackBarBackground,
        colorText: AppColor.background,
        icon: Icon(Icons.error_outline, color: AppColor.primary),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        reverseAnimationCurve: Curves.bounceIn,
      );
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<User?> googleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? googleUser = result.user;

      model.UserModel userModel = model.UserModel(
        apelido: '',
        localizacao: '',
        dataNasc: '',
        email: googleUser?.email,
        formacao: '',
        username: googleUser?.displayName,
        photoURL: googleUser?.photoURL,
        uid: googleUser?.uid,
      );

      if (result != null) {
        DatabaseMethods().addUserInfotoDB(result.user!.uid, userModel);
      }

      Get.snackbar(
        "Login",
        "Usuário conectado! (Google)",
        icon: Icon(Icons.check_circle_outline, color: AppColor.primary),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.snackBarBackground,
        colorText: AppColor.background,
      );

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await firebaseAuth.signOut();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.disconnect();
  }
}
