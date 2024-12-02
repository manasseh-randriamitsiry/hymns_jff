import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorController extends GetxController {
  // Theme colors
  final Rx<MaterialColor> primaryColor = Colors.purple.obs;
  final Rx<MaterialColor> accentColor = Colors.deepOrange.obs;
  final Rx<Color> textColor = Colors.black.obs;
  final Rx<Color> backgroundColor = Colors.white.obs;
  final Rx<Color> drawerColor = Colors.black.obs;
  final Rx<Color> iconColor = Colors.deepOrange.obs;

  // Predefined color schemes
  final List<Map<String, dynamic>> colorSchemes = [
    {
      'primary': Colors.purple,
      'accent': Colors.deepOrange,
      'text': Colors.black,
      'background': Colors.white,
      'drawer': Colors.black,
      'icon': Colors.deepOrange,
    },
    {
      'primary': Colors.blue,
      'accent': Colors.amber,
      'text': Colors.black,
      'background': Colors.white,
      'drawer': Colors.blueGrey,
      'icon': Colors.amber,
    },
    {
      'primary': Colors.teal,
      'accent': Colors.pink,
      'text': Colors.black,
      'background': Colors.white,
      'drawer': Colors.teal.shade900,
      'icon': Colors.pink,
    },
    {
      'primary': Colors.indigo,
      'accent': Colors.orange,
      'text': Colors.black,
      'background': Colors.white,
      'drawer': Colors.indigo.shade900,
      'icon': Colors.orange,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loadColors();
  }

  Future<void> loadColors() async {
    final prefs = await SharedPreferences.getInstance();

    // Load primary color (must be MaterialColor)
    final primaryColorValue = prefs.getInt('primaryColor') ?? Colors.purple.value;
    if (primaryColorValue == Colors.purple.value) {
      primaryColor.value = Colors.purple;
    } else if (primaryColorValue == Colors.deepOrange.value) {
      primaryColor.value = Colors.deepOrange;
    } else if (primaryColorValue == Colors.blue.value) {
      primaryColor.value = Colors.blue;
    } else if (primaryColorValue == Colors.amber.value) {
      primaryColor.value = Colors.amber;
    } else if (primaryColorValue == Colors.teal.value) {
      primaryColor.value = Colors.teal;
    } else if (primaryColorValue == Colors.pink.value) {
      primaryColor.value = Colors.pink;
    } else if (primaryColorValue == Colors.indigo.value) {
      primaryColor.value = Colors.indigo;
    } else if (primaryColorValue == Colors.orange.value) {
      primaryColor.value = Colors.orange;
    } else {
      primaryColor.value = Colors.purple; // Default fallback
    }

    // Load accent color (must be MaterialColor)
    final accentColorValue = prefs.getInt('accentColor') ?? Colors.deepOrange.value;
    if (accentColorValue == Colors.purple.value) {
      accentColor.value = Colors.purple;
    } else if (accentColorValue == Colors.deepOrange.value) {
      accentColor.value = Colors.deepOrange;
    } else if (accentColorValue == Colors.blue.value) {
      accentColor.value = Colors.blue;
    } else if (accentColorValue == Colors.amber.value) {
      accentColor.value = Colors.amber;
    } else if (accentColorValue == Colors.teal.value) {
      accentColor.value = Colors.teal;
    } else if (accentColorValue == Colors.pink.value) {
      accentColor.value = Colors.pink;
    } else if (accentColorValue == Colors.indigo.value) {
      accentColor.value = Colors.indigo;
    } else if (accentColorValue == Colors.orange.value) {
      accentColor.value = Colors.orange;
    } else {
      accentColor.value = Colors.deepOrange; // Default fallback
    }

    // Load other colors (regular Colors)
    textColor.value = Color(prefs.getInt('textColor') ?? Colors.black.value);
    backgroundColor.value = Color(prefs.getInt('backgroundColor') ?? Colors.white.value);
    drawerColor.value = Color(prefs.getInt('drawerColor') ?? Colors.black.value);
    iconColor.value = Color(prefs.getInt('iconColor') ?? Colors.deepOrange.value);
  }

  Future<void> saveColors() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('primaryColor', primaryColor.value.value);
    await prefs.setInt('accentColor', accentColor.value.value);
    await prefs.setInt('textColor', textColor.value.value);
    await prefs.setInt('backgroundColor', backgroundColor.value.value);
    await prefs.setInt('drawerColor', drawerColor.value.value);
    await prefs.setInt('iconColor', iconColor.value.value);
  }

  void updateColors({
    Color? primary,
    Color? accent,
    Color? text,
    Color? background,
    Color? drawer,
    Color? icon,
  }) {
    // Only update if the color is provided
    if (primary != null && primary is MaterialColor) primaryColor.value = primary;
    if (accent != null && accent is MaterialColor) accentColor.value = accent;
    if (text != null) textColor.value = text;
    if (background != null) backgroundColor.value = background;
    if (drawer != null) drawerColor.value = drawer;
    if (icon != null) iconColor.value = icon;
    saveColors();
  }

  void applyColorScheme(int index) {
    if (index >= 0 && index < colorSchemes.length) {
      final scheme = colorSchemes[index];
      updateColors(
        primary: scheme['primary'] as MaterialColor,
        accent: scheme['accent'] as MaterialColor,
        text: scheme['text'] as Color,
        background: scheme['background'] as Color,
        drawer: scheme['drawer'] as Color,
        icon: scheme['icon'] as Color,
      );
    }
  }

  ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: primaryColor.value,
      primaryColor: primaryColor.value,
      iconTheme: IconThemeData(color: iconColor.value),
      dividerColor: Colors.white,
      hintColor: textColor.value,
      scaffoldBackgroundColor: backgroundColor.value,
      colorScheme: ColorScheme.light(
        primary: primaryColor.value,
        secondary: accentColor.value,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: textColor.value),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: drawerColor.value,
        elevation: 10,
        surfaceTintColor: drawerColor.value,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor.value),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200]!,
        labelStyle: TextStyle(color: textColor.value),
        shape: const StadiumBorder(),
        side: BorderSide(color: Colors.grey[400]!),
        disabledColor: Colors.grey[300]!,
        selectedColor: accentColor.value.withOpacity(0.3),
        secondarySelectedColor: accentColor.value.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        pressElevation: 4.0,
      ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: primaryColor.value,
      primaryColor: primaryColor.value,
      iconTheme: IconThemeData(color: iconColor.value),
      dividerColor: Colors.black,
      hintColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: primaryColor.value,
        secondary: accentColor.value,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: drawerColor.value,
        elevation: 10,
        surfaceTintColor: drawerColor.value,
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
        selectedColor: accentColor.value.withOpacity(0.7),
        secondarySelectedColor: accentColor.value.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        pressElevation: 4.0,
      ),
    );
  }
}
