import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/pages/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app_user/constants/constants.dart';
import 'package:ecommerce_app_user/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
      return false;
    }
  }

  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential? userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        image: null,
      );

      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());

      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
      return false;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signOut();

      Navigator.of(context, rootNavigator: true).pop();
      Routes.instance.pushAndRemoveUntil(
        widget: SplashScreen(),
        context: context,
      );
      showMessage("Đăng xuất thành công");
    } catch (e) {
      Navigator.of(context).pop();
      showMessage("Lỗi khi đăng xuất: $e");
    }
    // await _auth.signOut();
  }

  Future<bool> changePassword(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);

      // _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Đã thay đổi Password");
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showMessage(e.code.toString());
      return false;
    }
  }
}
