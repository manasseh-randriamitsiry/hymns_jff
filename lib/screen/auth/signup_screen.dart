import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/controller/auth_controller.dart';

import '../../widgets/btn_widget.dart';
import '../../widgets/input_password_widget.dart';
import '../../widgets/input_widget.dart';
import '../../widgets/social_btn_widget.dart';
import 'home_screen.dart';

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
                  const SizedBox(height: 20),
                  const Text(
                    "Creer un compte et profiter de tous les services",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  InputWidget(
                    inputWidth: containerWidth,
                    inputHeigh: 60,
                    color: Colors.black45,
                    icon: Icons.person_outline,
                    text: 'Votre pseudo',
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 10),
                  InputWidget(
                    inputWidth: containerWidth,
                    inputHeigh: 60,
                    color: Colors.black45,
                    icon: Icons.email_outlined,
                    text: 'Saisissez votre email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 10),
                  InputPasswordWidget(
                    width: containerWidth,
                    height: 60,
                    icon: Icons.lock,
                    text: "Saisissez votre mot de passe",
                    color: Colors.black45,
                    controller: _passwordController1,
                  ),
                  const SizedBox(height: 10),
                  InputPasswordWidget(
                    width: containerWidth,
                    height: 60,
                    icon: Icons.lock,
                    text: "Confirmer votre mot de passe",
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
                        print(e.toString());
                      }
                    },
                    child: const btnWidget(
                      inputWidth: 350,
                      inputHeigh: 60,
                      text: "S'INSCRIRE",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 2 * screenWidth / 8,
                          color: Colors.black.withOpacity(0.2),
                          height: 2,
                        ),
                        Container(
                          child: const Text("ou continuer avec"),
                        ),
                        Container(
                          width: 2 * screenWidth / 8,
                          color: Colors.black.withOpacity(0.2),
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: const Text("J'ai un compte?"),
                    ),
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
                                      HomeScreen(),
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
            ),
          ],
        ),
      ),
    );
  }
}
