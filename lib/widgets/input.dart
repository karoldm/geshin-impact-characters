import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const Input({required this.controller, required this.focusNode, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxHeight: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          )),
    );
  }
}
