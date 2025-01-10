import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String text;

  const ListHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.lightGreen,
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 20)));
  }
}
