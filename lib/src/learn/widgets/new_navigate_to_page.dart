import 'package:flutter/material.dart';

class NavigateToPage extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Widget route;

  const NavigateToPage({
    super.key,
    this.icon = Icons.ac_unit, // Default value if not provided
    this.text = 'default route text', // Default value if not provided
    this.backgroundColor = Colors.transparent, // Default to transparent if not provided
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => route,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15),
          ),
          color: backgroundColor.withOpacity(0.7),
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10),
              ),
              color: Colors.blue.withOpacity(0.1),
            ),
            width:40,
            height: 40,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          tileColor: Colors.transparent, // Apply background color to the ListTile
        ),
      ),
    );
  }
}
