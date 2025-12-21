import 'package:ecommerce_app_user/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerce_app_user/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_user/constants/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isShowPassword = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Thay đổi mật khẩu",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Mật khẩu mới",
              prefixIcon: const Icon(Icons.password_sharp),
              suffixIcon: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                child: const Icon(
                  Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Nhập lại mật khẩu",
              prefixIcon: const Icon(Icons.password_sharp),
              suffixIcon: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                child: const Icon(
                  Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          PrimaryButton(
            title: "Xác nhận",
            onPressed: () async {
              if (_passwordController.text.isEmpty) {
                showMessage("Chưa nhập mật khẩu mới");
              } else if (_confirmPasswordController.text.isEmpty) {
                showMessage("Chưa nhập xác nhận mật khẩu");
              } else if (_confirmPasswordController.text ==
                  _passwordController.text) {
                FirebaseAuthHelper.instance
                    .changePassword(_passwordController.text, context);
              } else {
                showMessage("Không khớp mật khẩu");
              }
            },
          )
        ],
      ),
    );
  }
}
