import 'package:ecommerce_app_admin/models/user_model/user_model.dart';
import 'package:ecommerce_app_admin/provider/app_provider.dart';
import 'package:ecommerce_app_admin/screens/user_screen/widgets/single_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý người dùng"),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.getUserList.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              UserModel userModel = value.getUserList[index];
              return SingleUser(
                userModel: userModel,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
