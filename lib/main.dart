import 'package:fihirana/screen/accueil/accueil_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/theme_controller.dart';
import 'screen/accueil/home_screen.dart';
import 'package:fihirana/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    themeController.isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme, // Use your light theme from theme.dart
      darkTheme: darkTheme, // Use your dark theme from theme.dart
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/accueil', page: () => const AccueilScreen()),
      ],
    );
  }
}
