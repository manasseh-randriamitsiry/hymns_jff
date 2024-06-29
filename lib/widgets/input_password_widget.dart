import 'package:flutter/material.dart';

class InputPasswordWidget extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color color;
  final TextEditingController? controller;
  final double width;
  final double height;

  const InputPasswordWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    this.controller,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _InputPasswordWidgetState createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          width: 1,
          color: widget.color.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              widget.icon,
              color: widget.color.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: TextField(
              obscureText: _obscureText,
              keyboardType: TextInputType.text,
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.text,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: widget.color.withOpacity(0.6),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ],
      ),
    );
  }
}
