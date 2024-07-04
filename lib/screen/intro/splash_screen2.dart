import 'package:flutter/material.dart';
import 'package:permah_flutter/screen/auth/login_screen.dart';
import 'package:permah_flutter/screen/intro/splash_screen3.dart';
import 'package:permah_flutter/widgets/start_container1.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Groupe20.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight - 312),
                // Padding to prevent overlap with screen edges
                child: const StartContainer1(
                  route1: LoginScreen(),
                  route2: SplashScreen3(),
                  imageUrl: 'assets/images/Dot2.png',
                  text1:
                      "Créer et trouver des évenements facilement à un seul endroit ",
                  text2:
                      "In this app you can create any kind of events and you can join all event",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
