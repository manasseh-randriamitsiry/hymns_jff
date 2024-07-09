import 'package:flutter/material.dart';

class InputPasswordWidget extends StatefulWidget {
  const InputPasswordWidget({
    super.key,
    required this.lblText,
    this.errorText,
    this.controller,
  });

  final String lblText;
  final String? errorText;
  final TextEditingController? controller;

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final inputBorderColor = theme.hintColor;
    final hintColor = theme.hintColor;
    final errorColor = theme.hintColor;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: !_showPassword,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            labelText: widget.lblText,
            labelStyle: TextStyle(color: hintColor),
            prefixIcon: Icon(Icons.lock, color: primaryColor),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            contentPadding: const EdgeInsets.all(20),
            errorText: widget.errorText,
            errorStyle: TextStyle(color: errorColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: inputBorderColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
