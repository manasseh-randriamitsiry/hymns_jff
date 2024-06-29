import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/auth/home_screen.dart';

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
      builder: (context) => HomeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 312,
          decoration: BoxDecoration(
            color: Color(0xFFFF7E69),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                child: Center(
                  child: Text(
                    text1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                width: 300,
                height: 100,
              ),
              Container(
                child: Center(
                  child: Text(
                    text2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 14),
                  ),
                ),
                width: 300,
                height: 50,
              ),
              SizedBox(
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
                          Navigator.pop(context); // Close drawer
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      route1,
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ),
                          );
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
                          Navigator.pop(context); // Close drawer
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      route2,
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        child: Text(
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
