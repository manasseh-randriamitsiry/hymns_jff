import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: Colors.deepOrange),
  navigationDrawerTheme: NavigationDrawerThemeData(
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
  ),
  primaryColor: Colors.transparent,
  dividerColor: Colors.white,
  hintColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  drawerTheme: DrawerThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
      surfaceTintColor: Colors.black),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[200]!,
    // Light grey background
    labelStyle: TextStyle(color: Colors.black),
    // Black text for the light theme
    shape: StadiumBorder(),
    // Shape of the chip, you can customize it
    side: BorderSide(color: Colors.grey[400]!),
    // Border color
    disabledColor: Colors.grey[300]!,
    // Color when the chip is disabled
    selectedColor: Colors.blue[100]!,
    // Color when the chip is selected
    secondarySelectedColor: Colors.blue[200]!,
    // Secondary color for selected chip
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    // Padding inside the chip
    pressElevation: 4.0, // Elevation when pressed
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  dividerColor: Colors.black,
  iconTheme: IconThemeData(color: Colors.yellowAccent),
  navigationDrawerTheme: NavigationDrawerThemeData(
    surfaceTintColor: Colors.black,
    backgroundColor: Colors.white,
  ),
  primaryColor: Colors.transparent,
  hintColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.light(),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  drawerTheme: DrawerThemeData(
      backgroundColor: Colors.black,
      elevation: 10,
      surfaceTintColor: Colors.white),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[800]!,
    // Dark grey background
    labelStyle: TextStyle(color: Colors.white),
    // White text for the dark theme
    shape: StadiumBorder(),
    // Shape of the chip
    side: BorderSide(color: Colors.grey[600]!),
    // Border color
    disabledColor: Colors.grey[700]!,
    // Color when the chip is disabled
    selectedColor: Colors.orange[700]!,
    // Color when the chip is selected
    secondarySelectedColor: Colors.orange[600]!,
    // Secondary color for selected chip
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    // Padding inside the chip
    pressElevation: 4.0, // Elevation when pressed
  ),
);
