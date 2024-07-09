import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permah_flutter/screen/accueil/home_screen.dart';

import '../../services/api_service.dart';

class SplashScreenAuthenticated extends StatefulWidget {
  const SplashScreenAuthenticated({super.key});

  @override
  SplashScreenAuthenticatedState createState() =>
      SplashScreenAuthenticatedState();
}

class SplashScreenAuthenticatedState extends State<SplashScreenAuthenticated>
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
    Get.offAll(() => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                      width: screenWidth / 4,
                      height: screenHeight / 7,
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
