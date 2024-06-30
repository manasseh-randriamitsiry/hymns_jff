import 'package:flutter/material.dart';

class InputPasswordWidget extends StatefulWidget {
  const InputPasswordWidget({
    super.key,
    required this.lblText,
    this.errorText,
    required this.color,
    this.controller,
  });

  final String lblText;
  final String? errorText;
  final Color color;
  final TextEditingController? controller;

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.color),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            labelText: widget.lblText,
            // Use widget.lblText
            prefixIcon: Icon(Icons.lock, color: widget.color),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: widget.color,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            errorText: widget.errorText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.color),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.color),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
