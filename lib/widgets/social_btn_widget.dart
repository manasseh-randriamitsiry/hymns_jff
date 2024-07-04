import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SocialBtnWidget extends StatelessWidget {
  const SocialBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.hintColor;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                color: borderColor.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print("facebook");
                }
              },
              icon: Brand(
                Brands.facebook,
                size: 40,
              ),
              color: Colors.blue,
            ),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                color: borderColor.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print("google");
                }
              },
              icon: Brand(
                Brands.google,
                size: 40,
              ),
            ),
          ),
          Container(
            width: 90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                color: borderColor.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print("apple");
                }
              },
              icon: Brand(
                Brands.apple_logo,
                size: 40,
              ),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
