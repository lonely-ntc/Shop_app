import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  const TopTitles({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
