import 'package:flutter/material.dart';

class InputWidgetUtils extends StatelessWidget {
  final Color color;
  final String text;
  final IconData? icon;
  final double width;
  final double height;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const InputWidgetUtils({
    super.key,
    this.color = Colors.black,
    this.text = 'Default input text', // Default text
    this.icon,
    this.width = 300.0, // Default width
    this.height = 50.0, // Default height
    this.controller,
    this.keyboardType, // Initialize controller
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller, // Set the controller
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: color,
          ),
          prefixIcon: Icon(icon),
          filled: false,
          fillColor: Colors.lightBlue,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
