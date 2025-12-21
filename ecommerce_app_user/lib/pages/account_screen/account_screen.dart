import 'package:ecommerce_app_user/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:ecommerce_app_user/pages/change_password_screen/change_password_screen.dart';
import 'package:ecommerce_app_user/pages/edit_profile/edit_profile.dart';

import 'package:ecommerce_app_user/pages/favourite_screen/favourite_screen.dart';
import 'package:ecommerce_app_user/pages/order_screen/order_screen.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper.instance;
  FirebaseFirestoreHelper firebaseFirestoreHelper =
      FirebaseFirestoreHelper.instance;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Tài khoản",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Thông tin người dùng
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  appProvider.getUserInformation.image == null
                      ? const Icon(Icons.person_outline, size: 100)
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              appProvider.getUserInformation.image!),
                        ),
                  const SizedBox(height: 12),
                  Text(
                    appProvider.getUserInformation.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appProvider.getUserInformation.email,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const EditProfile(),
                          withNavBar: false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Sửa thông tin",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Menu
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                children: [
                  _buildListTile(
                    icon: Icons.shopping_bag_outlined,
                    title: "Đơn hàng của bạn",
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const OrderScreen(),
                        withNavBar: false,
                      );
                    },
                  ),
                  _buildListTile(
                    icon: Icons.favorite_outline,
                    title: "Sản phẩm yêu thích",
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const FavouriteScreen(),
                        withNavBar: false,
                      );
                    },
                  ),
                  _buildListTile(
                    icon: Icons.info_outline,
                    title: "Thông tin ứng dụng",
                    onTap: () {},
                  ),
                  _buildListTile(
                    icon: Icons.change_circle_outlined,
                    title: "Đổi mật khẩu",
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const ChangePasswordScreen(),
                        withNavBar: false,
                      );
                    },
                  ),
                  _buildListTile(
                    icon: Icons.logout,
                    title: "Đăng xuất",
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut(context);
                    },
                    iconColor: Colors.red,
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Version 4.0.0",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.black54,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: const TextStyle(fontSize: 15)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }
}
