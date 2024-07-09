import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/auth/login_screen.dart';

class StartContainer1 extends StatelessWidget {
  final String text1;
  final String text2;
  final Widget route1;
  final Widget route2;
  final String imageUrl;

  const StartContainer1({
    super.key,
    required this.text1,
    required this.text2,
    required this.route1,
    required this.route2,
    required this.imageUrl,
  });

  Future<void> _completeSetup(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstUse', false);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: Text(
                    text1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 50,
                child: Center(
                  child: Text(
                    text2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Get.to(route1, transition: Transition.circularReveal);
                        },
                        child: GestureDetector(
                          onTap: () {
                            _completeSetup(context);
                          },
                          child: Text(
                            "Passer",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        imageUrl,
                        height: 10,
                        width: 100,
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Get.to(route2, transition: Transition.circularReveal);
                        },
                        child: const Text(
                          "Suivant",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
