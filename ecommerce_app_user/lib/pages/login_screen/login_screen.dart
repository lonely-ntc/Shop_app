import 'package:ecommerce_app_user/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_user/constants/constants.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/pages/signup_screen/signup_screen.dart';
import 'package:ecommerce_app_user/pages/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:ecommerce_app_user/widgets/primary_button/primary_button.dart';
import 'package:ecommerce_app_user/widgets/top_titles/top_titles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPass = true;

  // Email, Password
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.0,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopTitles(
            title: "Đăng nhập",
            subtitle: "Chào bạn đến với ứng dụng của tôi",
          ),
          const SizedBox(height: 45),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _password,
            obscureText: isShowPass,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: const Icon(Icons.password),
              suffixIcon: CupertinoButton(
                onPressed: () {
                  setState(() {
                    isShowPass = !isShowPass;
                  });
                },
                child: isShowPass
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            onPressed: () async {
              bool isValidated = loginValidation(_email.text, _password.text);

              if (isValidated) {
                try {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .login(_email.text, _password.text, context);
                  if (isLogined) {
                    Routes.instance.pushAndRemoveUntil(
                      widget: const CustomBottomBar(),
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
            title: "Đăng nhập",
          ),
          const SizedBox(height: 20),
          chuaDangKy(),
        ],
      ),
    );
  }

  Widget chuaDangKy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Bạn chưa có tài khoản?",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        CupertinoButton(
          onPressed: () {
            Routes.instance.push(
              widget: const SignupScreen(),
              context: context,
            );
          },
          child: const Text(
            "Đăng ký",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
