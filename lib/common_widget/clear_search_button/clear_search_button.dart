import 'package:flutter/material.dart';

class ClearSearchButton extends StatelessWidget {
  final VoidCallback onTap;

  const ClearSearchButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.close),
    );
  }
}