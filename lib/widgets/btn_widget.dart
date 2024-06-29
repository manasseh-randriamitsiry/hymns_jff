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
    return Column(
      children: [
        Container(
          width: inputWidth,
          height: inputHeigh,
          decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
