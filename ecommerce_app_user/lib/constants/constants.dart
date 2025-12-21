import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.black,
    gravity: ToastGravity.TOP,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            const SizedBox(height: 18),
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading..."),
            )
          ],
        ),
      );
    }),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USER":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email này đã được sử dụng";

    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Sai mật khẩu";

    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "Không tìm thấy người dùng này";

    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "Tài khoản này đã bị vô hiệu hóa";

    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Quá nhiều yêu cầu đăng nhập. Hãy thử lại sau!";

    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email không hợp lệ";

    case "invalid-credential":
      return "Thông tin đăng nhập không hợp lệ. Vui lòng kiểm tra lại.";

    default:
      return "Lỗi đăng nhập. Vui lòng thử lại.";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Hãy nhập Email và Password");
    return false;
  } else if (!EmailValidator.validate(email)) {
    showMessage("Email không hợp lệ");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email chưa nhập");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password chưa nhập");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("Hãy nhập đầy đủ thông tin");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email chưa nhập");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password chưa nhập");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name chưa nhập");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone chưa nhập");
    return false;
  } else {
    return true;
  }
}
