import 'package:flutter/material.dart';
import 'package:permah_flutter/screen/intro/splash_screen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Future<void> completeSetup(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstUse', false);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Groupe19.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight - 312),
                // Padding to prevent overlap with screen edges
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 312,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF7E69),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const SizedBox(
                            width: 300,
                            height: 100,
                            child: Center(
                              child: Text(
                                "Regarder des concerts gratuits avec des amis",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Find and booking concert near you! Invite your friends to watch together",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close drawer
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const SplashScreen1(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 120),
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: GestureDetector(
                                      child: const Text(
                                        "COMMENCER",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onTap: () {
                                        completeSetup(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
