import 'package:fihirana/screen/intro/splash_screen1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/theme_controller.dart';
import 'controller/font_controller.dart';
import 'screen/accueil/home_screen.dart';
import 'screen/accueil/accueil_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FontController fontController = Get.put(FontController());

  MyApp({super.key, required this.prefs});

  ThemeData _getThemeWithFont(ThemeData baseTheme, String fontFamily) {
    final TextTheme textTheme = GoogleFonts.getTextTheme(fontFamily);
    return baseTheme.copyWith(
      textTheme: textTheme.apply(
        bodyColor: baseTheme.textTheme.bodyLarge?.color,
        displayColor: baseTheme.textTheme.displayLarge?.color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    themeController.isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    
    // Check if it's the first time launching the app
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    
    return Obx(() {
      final currentFont = fontController.currentFont.value;
      
      // Create theme data with current font
      final lightThemeWithFont = _getThemeWithFont(lightTheme, currentFont);
      final darkThemeWithFont = _getThemeWithFont(darkTheme, currentFont);

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: lightThemeWithFont,
        darkTheme: darkThemeWithFont,
        home: isFirstTime ? SplashScreen1() : const HomeScreen(),
        getPages: [
          GetPage(name: '/accueil', page: () => const AccueilScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
        ],
      );
    });
  }
}
