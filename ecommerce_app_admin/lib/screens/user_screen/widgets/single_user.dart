import 'package:ecommerce_app_admin/constants/routes.dart';
import 'package:ecommerce_app_admin/models/user_model/user_model.dart';
import 'package:ecommerce_app_admin/provider/app_provider.dart';
import 'package:ecommerce_app_admin/screens/user_screen/edit_user/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleUser extends StatefulWidget {
  const SingleUser({super.key, required this.userModel, required this.index});

  final UserModel userModel;
  final int index;

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            widget.userModel.image != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(widget.userModel.image!),
                    // child: Icon(Icons.person),
                  )
                : const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userModel.name),
                Text(widget.userModel.email),
              ],
            ),
            const Spacer(),
            isLoading
                ? const CircularProgressIndicator()
                : GestureDetector(
                    // padding: EdgeInsets.zero,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appProvider
                          .deleteUserFromFirebase(widget.userModel);

                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Icon(Icons.delete),
                  ),
            const SizedBox(width: 6),
            GestureDetector(
              // padding: EdgeInsets.zero,
              onTap: () async {
                Routes.instance.push(
                  widget: EditUser(
                    index: widget.index,
                    userModel: widget.userModel,
                  ),
                  context: context,
                );
              },
              child: const Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }
}
