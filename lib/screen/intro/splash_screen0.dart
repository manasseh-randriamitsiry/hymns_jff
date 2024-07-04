import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';
import '../auth/login_screen.dart'; // Import necessary screens
import 'splash_screen1.dart';

class SplashScreen0 extends StatefulWidget {
  const SplashScreen0({super.key});

  @override
  SplashScreen0State createState() => SplashScreen0State();
}

class SplashScreen0State extends State<SplashScreen0>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ApiService apiService = ApiService();
  late Timer _timer;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    // Start periodic connectivity checks
    _startPeriodicConnectivityCheck();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startPeriodicConnectivityCheck() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        _isConnected = connectivityResult != ConnectivityResult.none;
      });

      if (_isConnected) {
        // If connected, stop the timer and preload data
        _timer.cancel();
        _preloadData();
      }
    });
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
      await ApiService().fetchMembers(); // Example: pre-loading members
    }

    // Navigate based on the last route or whether it is the first use
    if (isFirstUse) {
      Get.offAll(() => const SplashScreen1());
    } else if (lastRoute != null) {
      Get.offAllNamed(lastRoute);
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
                    child: Image.asset(
                      'assets/images/img_1.png',
                      width: 200,
                      height: 200,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400,
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Always show the loading animation
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.black,
                      size: 100,
                    ),
                    // Show different text based on connection status
                    if (!_isConnected) ...[
                      const SizedBox(height: 20),
                      // Add some space between animation and text
                      const Text(
                        'Pas de connexion internet.\nEn attente de connexion ...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 20),
                      // Add some space between animation and text
                      const Text(
                        'Veuillez patientez ...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
