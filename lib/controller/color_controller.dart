import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorController extends GetxController {
  static ColorController get to => Get.find();

  // Theme colors
  final Rx<MaterialColor> primaryColor = Colors.purple.obs;
  final Rx<Color> accentColor = Colors.deepOrange.obs;
  final Rx<Color> textColor = Colors.black.obs;
  final Rx<Color> backgroundColor = Colors.white.obs;
  final Rx<Color> drawerColor = Colors.black.obs;
  final Rx<Color> iconColor = Colors.deepOrange.obs;

  // Current color scheme index
  final RxInt currentSchemeIndex = 0.obs;

  // Predefined color schemes
  final List<Map<String, dynamic>> colorSchemes = [
    {
      'name': 'Classic Purple',
      'primary': Colors.purple,
      'accent': Colors.deepOrange,
      'text': Colors.black87,
      'background': Colors.white,
      'drawer': Colors.purple.shade900,
      'icon': Colors.deepOrange,
    },
    {
      'name': 'Ocean Blue',
      'primary': Colors.blue,
      'accent': Colors.amber,
      'text': Colors.black87,
      'background': Colors.white,
      'drawer': Colors.blue.shade900,
      'icon': Colors.amber,
    },
    {
      'name': 'Forest Green',
      'primary': Colors.teal,
      'accent': Colors.pink,
      'text': Colors.black,
      'background': Colors.white,
      'drawer': Colors.teal.shade900,
      'icon': Colors.pink,
    },
    {
      'name': 'Royal Purple',
      'primary': Colors.indigo,
      'accent': Colors.orange,
      'text': Colors.black87,
      'background': Colors.white,
      'drawer': Colors.indigo.shade900,
      'icon': Colors.orange,
    },
    {
      'name': 'Dark Theme',
      'primary': Colors.grey,
      'accent': Colors.deepPurpleAccent,
      'text': Colors.white,
      'background': Colors.black,
      'drawer': Colors.grey.shade900,
      'icon': Colors.deepPurpleAccent,
    },
  ];

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;
    final int primary = color.value;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(primary, shades);
  }

  @override
  void onInit() {
    super.onInit();
    loadColors();
  }

  Future<void> loadColors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedIndex = prefs.getInt('colorSchemeIndex') ?? 0;
      await setColorScheme(savedIndex);
    } catch (e) {
      print('Error loading colors: $e');
      setColorScheme(0);
    }
  }

  Future<void> setColorScheme(int index) async {
    try {
      if (index >= 0 && index < colorSchemes.length) {
        final scheme = colorSchemes[index];

        // Update all colors
        primaryColor.value = scheme['primary'] as MaterialColor;
        accentColor.value = scheme['accent'] as Color;
        textColor.value = scheme['text'] as Color;
        backgroundColor.value = scheme['background'] as Color;
        drawerColor.value = scheme['drawer'] as Color;
        iconColor.value = scheme['icon'] as Color;

        currentSchemeIndex.value = index;

        // Save to preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('colorSchemeIndex', index);

        // Update system UI overlay style
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                _isDark(backgroundColor.value) ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: backgroundColor.value,
            systemNavigationBarIconBrightness:
                _isDark(backgroundColor.value) ? Brightness.light : Brightness.dark,
          ),
        );

        // Force update
        update();
        Get.forceAppUpdate();
      }
    } catch (e) {
      print('Error setting color scheme: $e');
    }
  }

  bool _isDark(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
  }

  // Get the current color scheme name
  String get currentSchemeName =>
      colorSchemes[currentSchemeIndex.value]['name'] as String;

  // Get current theme mode
  ThemeMode get themeMode =>
      _isDark(backgroundColor.value) ? ThemeMode.dark : ThemeMode.light;

  // Cycle to the next color scheme
  Future<void> nextColorScheme() async {
    int nextIndex = (currentSchemeIndex.value + 1) % colorSchemes.length;
    await setColorScheme(nextIndex);
  }

  // Set previous color scheme
  Future<void> previousColorScheme() async {
    int prevIndex = currentSchemeIndex.value - 1;
    if (prevIndex < 0) prevIndex = colorSchemes.length - 1;
    await setColorScheme(prevIndex);
  }

  // Update individual colors
  void updateColors({
    Color? primary,
    Color? accent,
    Color? text,
    Color? background,
    Color? drawer,
    Color? icon,
  }) {
    if (primary != null) primaryColor.value = getMaterialColor(primary);
    if (accent != null) accentColor.value = accent;
    if (text != null) textColor.value = text;
    if (background != null) backgroundColor.value = background;
    if (drawer != null) drawerColor.value = drawer;
    if (icon != null) iconColor.value = icon;

    update();
    Get.forceAppUpdate();
  }

  // Get light theme data
  ThemeData getLightTheme() {
    final context = Get.context;
    final materialColor = primaryColor.value;
    
    if (context == null) {
      return ThemeData(
        brightness: Brightness.light,
        primaryColor: materialColor.shade500,
        primarySwatch: materialColor,
        colorScheme: ColorScheme.light(
          primary: materialColor.shade500,
          secondary: accentColor.value,
          background: backgroundColor.value,
          surface: backgroundColor.value,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: textColor.value,
          onBackground: textColor.value,
        ),
      );
    }

    return Theme.of(context).copyWith(
      brightness: Brightness.light,
      primaryColor: materialColor.shade500,
      colorScheme: ColorScheme.light(
        primary: materialColor.shade500,
        secondary: accentColor.value,
        background: backgroundColor.value,
        surface: backgroundColor.value,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor.value,
        onBackground: textColor.value,
      ),
    );
  }

  // Get dark theme data
  ThemeData getDarkTheme() {
    final context = Get.context;
    final materialColor = primaryColor.value;
    
    if (context == null) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: materialColor.shade500,
        primarySwatch: materialColor,
        colorScheme: ColorScheme.dark(
          primary: materialColor.shade500,
          secondary: accentColor.value,
          background: backgroundColor.value,
          surface: backgroundColor.value,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: textColor.value,
          onBackground: textColor.value,
        ),
      );
    }

    return Theme.of(context).copyWith(
      brightness: Brightness.dark,
      primaryColor: materialColor.shade500,
      colorScheme: ColorScheme.dark(
        primary: materialColor.shade500,
        secondary: accentColor.value,
        background: backgroundColor.value,
        surface: backgroundColor.value,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor.value,
        onBackground: textColor.value,
      ),
    );
  }
}