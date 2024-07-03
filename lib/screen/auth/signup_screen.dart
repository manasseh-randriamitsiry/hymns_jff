import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/controller/auth_controller.dart';

import '../../widgets/btn_widget.dart';
import '../../widgets/input_password_widget.dart';
import '../../widgets/input_widget.dart';
import '../../widgets/social_btn_widget.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth - 50;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Creer un compte",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: containerWidth,
              child: Column(
                children: [
                  SizedBox(height: screenHeight / 40),
                  const Text(
                    "Creer un compte et profiter de tous les services",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight / 40),
                  InputWidget(
                    color: Colors.black45,
                    icon: Icons.person_outline,
                    labelText: 'Votre pseudo',
                    controller: _usernameController,
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  InputWidget(
                    color: Colors.black45,
                    icon: Icons.email_outlined,
                    labelText: 'Saisissez votre email',
                    controller: _emailController,
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  InputPasswordWidget(
                    lblText: "Saisissez votre mot de passe",
                    color: Colors.black45,
                    controller: _passwordController1,
                  ),
                  const SizedBox(height: 10),
                  InputPasswordWidget(
                    lblText: "Saisissez votre mot de passe",
                    color: Colors.black45,
                    controller: _passwordController2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _authController.signup(
                          _usernameController.text,
                          _passwordController1.text,
                          _passwordController2.text,
                          _emailController.text,
                        );
                      } catch (e) {
                        if (kDebugMode) {
                          print(e.toString());
                        }
                      }
                    },
                    child: btnWidget(
                      inputWidth: containerWidth,
                      inputHeigh: screenHeight / 12,
                      text: "S'INSCRIRE",
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 2 * screenWidth / 8,
                        color: Colors.black.withOpacity(0.2),
                        height: 2,
                      ),
                      const Text("ou continuer avec"),
                      Container(
                        width: 2 * screenWidth / 8,
                        color: Colors.black.withOpacity(0.2),
                        height: 2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 20,
                  ),
                  SizedBox(
                    width: containerWidth - 40,
                    child: const SocialBtnWidget(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight - 115, // 20 pixels from the top of the screen
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("J'ai un compte?"),
                  GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close drawer
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    LoginScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Connectez-vous",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
