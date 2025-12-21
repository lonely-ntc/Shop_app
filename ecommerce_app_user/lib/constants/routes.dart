import 'package:flutter/material.dart';
// import 'package:ecommerce_app_user/pages/auth/login/login.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushAndRemoveUntil({
    required Widget widget,
    required BuildContext context,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => widget),
      (route) => false,
    );
  }

  Future<dynamic> push({
    required Widget widget,
    required BuildContext context,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => widget),
    );
  }
}
