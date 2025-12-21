import 'package:ecommerce_app_user/constants/theme.dart';
import 'package:ecommerce_app_user/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app_user/firebase_options.dart';
import 'package:ecommerce_app_user/pages/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:ecommerce_app_user/pages/splash_screen/splash_screen.dart';
import 'package:ecommerce_app_user/pages/welcome_screen/welcome_screen.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51QLqOfK8ny5qNzn7IiByB4si4EqbzJpA3r3aazE0Pg0ufpS0F4KX1R6mrZgBtzjBw3bUGzl3Iz85qecbrjVG9Gnl00zfQHdr62";
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
