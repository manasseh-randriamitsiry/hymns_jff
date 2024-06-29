import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color buttonOnPressedColor;
  final Color textOnPressedColor;
  final String text;
  final IconData? icon;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.green,
    this.text = 'Default', // Default text
    this.icon,
    this.buttonOnPressedColor = const Color.fromRGBO(10, 58, 34, 1.0),
    this.textOnPressedColor = Colors.white,
    this.width = 100.0, // Default width
    this.height = 50.0, // Default height
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return buttonOnPressedColor;
              } else if (states.contains(WidgetState.hovered)) {
                return Colors.blue[700]!;
              } else if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return backgroundColor;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return textOnPressedColor;
              } else if (states.contains(WidgetState.hovered)) {
                return Colors.white70;
              } else if (states.contains(WidgetState.disabled)) {
                return Colors.black38;
              }
              return textColor;
            },
          ),
          shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                );
              }
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              );
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: textColor),
            if (icon != null) SizedBox(width: 8), // Add some spacing between the icon and the text
            Text(text),
          ],
        ),
      ),
    );
  }
}
