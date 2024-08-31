import 'package:flutter/material.dart';

class Rarity extends StatelessWidget {
  final int rarity;

  const Rarity({required this.rarity, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          size: 28,
          color: index < rarity
              ? const Color.fromARGB(255, 224, 202, 0)
              : const Color.fromARGB(255, 207, 207, 207),
        ),
      ),
    );
  }
}
