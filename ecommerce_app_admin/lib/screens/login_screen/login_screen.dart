import 'package:ecommerce_app_admin/constants/constants.dart';
import 'package:ecommerce_app_admin/constants/routes.dart';
import 'package:ecommerce_app_admin/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerce_app_admin/screens/home_screen/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPass = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Tiêu đề
                const Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "TRANG ADMIN",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Nhập email
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Nhập password
                TextFormField(
                  controller: _password,
                  obscureText: isShowPass,
                  decoration: InputDecoration(
                    hintText: "Mật khẩu",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isShowPass ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isShowPass = !isShowPass;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Nút đăng nhập
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isValidated =
                          loginValidation(_email.text, _password.text);
                      if (isValidated) {
                        try {
                          bool isLogined = await FirebaseAuthHelper.instance
                              .login(_email.text, _password.text, context);
                          if (isLogined) {
                            Routes.instance.pushAndRemoveUntil(
                              widget: const HomeScreen(),
                              context: context,
                            );
                            showMessage("Đăng nhập thành công");
                          }
                        } on FirebaseAuthException catch (e) {
                          showMessage(getMessageFromErrorCode(e.code));
                        } catch (e) {
                          showMessage("Lỗi không xác định. Vui lòng thử lại!");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
