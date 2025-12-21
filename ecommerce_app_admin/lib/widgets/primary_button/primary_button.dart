import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
