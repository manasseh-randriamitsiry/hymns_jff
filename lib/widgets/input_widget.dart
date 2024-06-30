import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final String? errorText;
  final Color color;
  final TextInputType type;
  final TextEditingController? controller;

  const InputWidget({
    super.key,
    required this.icon,
    required this.labelText,
    required this.color,
    this.controller,
    required this.type,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        keyboardType: type,
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          errorText: errorText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
        ),
      ),
    );
  }
}
