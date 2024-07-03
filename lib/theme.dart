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
);
