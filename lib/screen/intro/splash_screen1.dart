import 'package:flutter/material.dart';
import 'package:permah_flutter/screen/intro/splash_screen2.dart';
import 'package:permah_flutter/widgets/start_container1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/home_screen.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  Future<void> _completeSetup(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstUse', false);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeigh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Groupe21.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeigh - 312),
                // app bar is 70
                // Padding to prevent overlap with screen edges
                child: StartContainer1(
                  route1: HomeScreen(),
                  route2: const SplashScreen2(),
                  imageUrl: 'assets/images/Dot1.png',
                  text1: "Événement à venir et à proximité",
                  text2:
                      "In publishing and grahic design, lorem is a placeholder text commonly",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
