import 'package:flutter/material.dart';

import '../../utility/screen_util.dart';

class InputWidget extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final String? errorText;
  final TextInputType type;
  final TextEditingController? controller;

  const InputWidget({
    super.key,
    required this.icon,
    required this.labelText,
    this.controller,
    required this.type,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final inputBorderColor = theme.hintColor;
    final hintColor = theme.hintColor;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    bool tablet = isTablet(context);

    return SizedBox(
      child: TextField(
        keyboardType: type,
        controller: controller,
        style: TextStyle(fontSize: 14, color: textColor),
        decoration: InputDecoration(
          contentPadding:
              tablet ? const EdgeInsets.all(30) : const EdgeInsets.all(20),
          labelText: labelText,
          labelStyle: TextStyle(color: hintColor),
          errorText: errorText,
          errorStyle: TextStyle(color: theme.hintColor),
          prefixIcon: Icon(
            icon,
            color: primaryColor,
          ),
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
    );
  }
}
