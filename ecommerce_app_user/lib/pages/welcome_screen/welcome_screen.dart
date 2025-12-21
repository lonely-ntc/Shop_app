import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_user/constants/asset_image.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/pages/login_screen/login_screen.dart';
import 'package:ecommerce_app_user/pages/signup_screen/signup_screen.dart';
import 'package:ecommerce_app_user/widgets/primary_button/primary_button.dart';
import 'package:ecommerce_app_user/widgets/top_titles/top_titles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                title: "Welcome",
                subtitle: "Mua những sản phẩm từ ứng dụng",
              ),
              Center(
                child: Image.asset(AssetsImages.instance.welcomeImage),
              ),
              const SizedBox(height: 170.0),
              PrimaryButton(
                title: "Đăng nhập",
                onPressed: () {
                  Routes.instance.push(
                    widget: const LoginScreen(),
                    context: context,
                  );
                },
              ),
              const SizedBox(height: 18.0),
              PrimaryButton(
                title: "Đăng ký",
                onPressed: () {
                  Routes.instance.push(
                    widget: const SignupScreen(),
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
