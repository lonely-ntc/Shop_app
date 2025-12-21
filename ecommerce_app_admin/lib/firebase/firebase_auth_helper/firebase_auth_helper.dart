import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_admin/constants/routes.dart';
import 'package:ecommerce_app_admin/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app_admin/constants/constants.dart';
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
      // Chặn đăng nhập nếu email không phải là email admin
      if (email.toLowerCase().trim() != "admin@gmail.com" &&
          password.trim() != "admin123123") {
        Navigator.of(context).pop();
        showMessage("Bạn không có quyền truy cập trang quản trị");
        return false;
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password);

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
        widget: const LoginScreen(),
        context: context,
      );
      showMessage("Đăng xuất thành công");
    } catch (e) {
      Navigator.of(context).pop();
      showMessage("Lỗi khi đăng xuất: $e");
    }
    // await _auth.signOut();
  }
}
