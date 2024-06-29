import 'package:flutter/material.dart';

import 'input_widget_util.dart';

class InputWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final double inputWidth;
  final double inputHeigh;
  final TextEditingController? controller;

  const InputWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    this.controller,
    required this.inputWidth,
    required this.inputHeigh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inputWidth,
      height: inputHeigh,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          width: 1,
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InputWidgetUtils(
              text: text,
              color: color,
              keyboardType: TextInputType.emailAddress,
              controller: controller,
              icon: icon),
          Icon(
            Icons.remove_red_eye_rounded,
            color: color.withOpacity(0),
          ),
        ],
      ),
    );
  }
}
