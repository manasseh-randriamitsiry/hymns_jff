import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Light theme configuration
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  iconTheme: const IconThemeData(color: Colors.deepOrange),
  primaryColor: Colors.purple,
  dividerColor: Colors.white,
  hintColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
  cardColor: Colors.white,
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black,
    elevation: 10,
    surfaceTintColor: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[200]!,
    labelStyle: const TextStyle(color: Colors.black),
    shape: const StadiumBorder(),
    side: BorderSide(color: Colors.grey[400]!),
    disabledColor: Colors.grey[300]!,
    selectedColor: Colors.blue[100]!,
    secondarySelectedColor: Colors.blue[200]!,
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    pressElevation: 4.0,
  ),
);

/// Dark theme configuration
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  dividerColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.yellowAccent),
  navigationDrawerTheme: const NavigationDrawerThemeData(
    surfaceTintColor: Colors.black,
    backgroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black,
    elevation: 10,
    surfaceTintColor: Colors.black,
  ),
  primaryColor: Colors.blue,
  hintColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: const ColorScheme.light(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[800]!,
    labelStyle: const TextStyle(color: Colors.white),
    shape: const StadiumBorder(),
    side: BorderSide(color: Colors.grey[600]!),
    disabledColor: Colors.grey[700]!,
    selectedColor: Colors.orange[700]!,
    secondarySelectedColor: Colors.orange[600]!,
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    pressElevation: 4.0, // Elevation when pressed
  ),
);
