import 'package:ecommerce_app_admin/constants/theme.dart';
import 'package:ecommerce_app_admin/firebase_options.dart';
import 'package:ecommerce_app_admin/provider/app_provider.dart';
import 'package:ecommerce_app_admin/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app_admin/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'ADMIN',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const LoginScreen(),
      ),
    );
  }
}
