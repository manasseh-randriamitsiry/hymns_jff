import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:permah_flutter/services/api_service.dart';

import '../auth/login_screen.dart';

class SplashScreen1 extends StatelessWidget {
  static const TextStyle greyStyle =
      TextStyle(fontSize: 40.0, color: Colors.grey);
  static const TextStyle whiteStyle =
      TextStyle(fontSize: 40.0, color: Colors.white);

  static const TextStyle boldStyle = TextStyle(
    fontSize: 50.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.grey,
    fontSize: 20.0,
  );

  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  final ApiService apiService = Get.put(ApiService());

  SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final pages = [
      Container(
        color: Colors.yellowAccent.shade700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: screenWidth * 0.7,
              height: screenWidth * 0.7,
              child: SvgPicture.asset(
                "assets/images/undraw_mello_otq1.svg",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Concert",
                    style: boldStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Créer et trouver des évenements facilement à un seul endroit ",
                    style: descriptionGreyStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "passer",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.fast_forward,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              onTap: () {
                Get.off(const LoginScreen());
              },
            )
          ],
        ),
      ),
      Container(
        color: const Color(0xFF55006c),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: screenWidth * 0.7,
              height: screenWidth * 0.7,
              child: SvgPicture.asset(
                "assets/images/undraw_video_game_night_8h8m.svg",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Evenements",
                    style: boldStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Chercher des evenements et inviter tes amis a rejoindre",
                    style: descriptionWhiteStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "passer",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.fast_forward,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              onTap: () {
                Get.off(const LoginScreen());
              },
            )
          ],
        ),
      ),
      Container(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: screenWidth * 0.7,
              height: screenWidth * 0.7,
              child: SvgPicture.asset(
                "assets/images/undraw_virtual_reality_re_yg8i.svg",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Loisirs",
                    style: boldStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Inviter des amis a un evenement chaud ",
                    style: descriptionWhiteStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "passer",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.fast_forward,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              onTap: () {
                Get.off(const LoginScreen());
              },
            )
          ],
        ),
      ),
      Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: screenWidth * 0.7,
              height: screenWidth * 0.7,
              child: SvgPicture.asset(
                "assets/images/undraw_basketball_re_7701.svg",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Bonjour",
                    style: boldStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Hola",
                    style: descriptionWhiteStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          enableLoop: false,
          fullTransitionValue: 300,
          slideIconWidget: const Icon(Icons.navigate_next),
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.5,
          onPageChangeCallback: (activePageIndex) {
            if (activePageIndex == pages.length - 1) {
              Get.off(const LoginScreen());
            }
          },
        ),
      ),
    );
  }
}
