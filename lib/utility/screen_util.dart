import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool isTablet(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final size = mediaQuery.size;
  final diagonal = sqrt(size.width * size.width + size.height * size.height);
  final isTablet = diagonal > 1100.0;
  return isTablet;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getContainerWidth(BuildContext context) {
  return getScreenWidth(context) - 50;
}

double getContainerHeight(BuildContext context) {
  return getScreenHeight(context) - 50;
}

double getContainerHeightWithAppBar(BuildContext context) {
  return getScreenHeight(context) - 100;
}

double getContainerHeightWithAppBarAndFooter(BuildContext context) {
  return getScreenHeight(context) - 150;
}

double getContainerHeightWithAppBarAndFooterAndTabBar(BuildContext context) {
  return getScreenHeight(context) - 200;
}

double getContainerHeightWithAppBarAndTabBar(BuildContext context) {
  return getScreenHeight(context) - 150;
}

double getContainerHeightWithFooter(BuildContext context) {
  return getScreenHeight(context) - 100;
}

double getContainerHeightWithTabBar(BuildContext context) {
  return getScreenHeight(context) - 100;
}

double getContainerHeightWithTabBarAndFooter(BuildContext context) {
  return getScreenHeight(context) - 150;
}

double getContainerHeightWithTabBarAndFooterAndAppBar(BuildContext context) {
  return getScreenHeight(context) - 200;
}

double getContainerHeightWithTabBarAndAppBar(BuildContext context) {
  return getScreenHeight(context) - 150;
}

void getHaptics() async {
  HapticFeedback.lightImpact();
}
