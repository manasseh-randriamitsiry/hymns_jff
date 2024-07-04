import 'package:flutter/material.dart';

class btnWidget extends StatelessWidget {
  final double inputWidth;
  final double inputHeigh;
  final String text;

  const btnWidget({
    super.key,
    required this.inputWidth,
    required this.inputHeigh,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputBorderColor = theme.hintColor;
    final textColor = theme.dividerColor;
    return Column(
      children: [
        Container(
          width: inputWidth,
          height: inputHeigh,
          decoration: BoxDecoration(
            color: inputBorderColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
