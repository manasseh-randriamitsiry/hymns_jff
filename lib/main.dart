import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permah_flutter/screen/auth/home_screen.dart';
import 'package:permah_flutter/screen/auth/interest_screen.dart';
import 'package:permah_flutter/screen/auth/reset_pass_screen.dart';
import 'package:permah_flutter/screen/auth/signup_screen.dart';
import 'package:permah_flutter/screen/auth/verification_page.dart';
import 'package:permah_flutter/screen/intro/splash_screen0.dart';
import 'package:permah_flutter/screen/intro/splash_screen1.dart';
import 'package:permah_flutter/screen/intro/splash_screen2.dart';
import 'package:permah_flutter/screen/intro/splash_screen3.dart';
import 'package:permah_flutter/screen/member/member_screen.dart';
import 'package:permah_flutter/screen/sortie/sortie_screen.dart';

import 'services/api_service.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: apiService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.fallingDot(
                color: Colors.black, size: 50),
          );
        } else if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          if (kDebugMode) {
            print('Redirecting to members with Token: ${snapshot.data}');
          }
          return _buildApp('/members');
        } else {
          print(
              'Redirecting to home. Token is null or empty: ${snapshot.data}');
          return _buildApp('/');
        }
      },
    );
  }

  Widget _buildApp(String initialRoute) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        // Additional light theme settings
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // Additional dark theme settings
      ),
      initial: AdaptiveThemeMode.light,
      // Use AdaptiveThemeMode.system for system default
      builder: (theme, darkTheme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: initialRoute,
        getPages: [
          GetPage(name: '/', page: () => SplashScreen0()),
          GetPage(name: '/splash1', page: () => const SplashScreen1()),
          GetPage(name: '/splash2', page: () => const SplashScreen2()),
          GetPage(name: '/splash3', page: () => const SplashScreen3()),
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/signup', page: () => SignupScreen()),
          GetPage(name: '/verify', page: () => const VerificationPage()),
          GetPage(name: '/resetPassword', page: () => const ResetPassScreen()),
          GetPage(
              name: '/interest', page: () => const InterestSelectionScreen()),
          GetPage(name: '/members', page: () => MembersScreen()),
          GetPage(name: '/sortie', page: () => SortieScreen()),
        ],
        initialBinding: BindingsBuilder(() {
          Get.put(ApiService());
        }),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
