import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';
import '../auth/home_screen.dart'; // Import necessary screens
import 'splash_screen1.dart';

class SplashScreen0 extends StatefulWidget {
  const SplashScreen0({super.key});

  @override
  _SplashScreen0State createState() => _SplashScreen0State();
}

class _SplashScreen0State extends State<SplashScreen0>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Future<void> _preloadFuture;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Start preloading data and checking the next screen
    _preloadFuture = _preloadData();
  }

  Future<void> _preloadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstUse = prefs.getBool('isFirstUse') ?? true;
    String? lastRoute = prefs.getString('lastRoute');

    // Simulate a delay for the splash screen
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // Pre-load necessary data (e.g., user details, settings)
    if (!isFirstUse) {
      // Simulate loading data, e.g., user info, preferences
      await ApiService().fetchMembers(); // Example: pre-loading members
    }

    // Navigate based on the last route or whether it is the first use
    if (isFirstUse) {
      Get.offAll(() => const SplashScreen1());
    } else if (lastRoute != null) {
      Get.offAllNamed(lastRoute);
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: FutureBuilder<void>(
          future: _preloadFuture,
          builder: (context, snapshot) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/splash.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.only(top: 200),
                      child: RotationTransition(
                        turns: _controller,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Colors.black12,
                          ),
                          child: CircleAvatar(
                              child: Image.asset('assets/images/img_1.png')),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 400,
                      padding: const EdgeInsets.only(bottom: 50),
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        // Customize the color as needed
                        size: 100, // Adjust the size as needed
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
