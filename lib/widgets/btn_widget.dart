import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  final double inputWidth;
  final double inputHeight;
  final String text;
  final Function onTap;

  const BtnWidget({
    super.key,
    required this.inputWidth,
    required this.inputHeight,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputBorderColor = theme.hintColor;
    final textColor = theme.dividerColor;

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: inputBorderColor, width: 0),
          ),
          color: inputBorderColor,
          child: SizedBox(
            width: inputWidth,
            height: inputHeight,
            child: InkWell(
              onTap: () {
                onTap();
              },
              borderRadius: BorderRadius.circular(15),
              splashColor: Colors.orange,
              hoverColor: Colors.green,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
