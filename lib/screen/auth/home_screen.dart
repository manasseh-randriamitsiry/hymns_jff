import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/auth/signup_screen.dart';
import 'package:permah_flutter/widgets/btn_widget.dart';
import 'package:permah_flutter/widgets/input_password_widget.dart';
import 'package:permah_flutter/widgets/input_widget.dart';
import 'package:permah_flutter/widgets/social_btn_widget.dart';

import '../../controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _switchValue = false.obs;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth - 50;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Connectez-vous",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print('back button tapped');
            }
          },
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: containerWidth,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Donner vos informations pour vous connecter à votre compte",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  InputWidget(
                    inputWidth: containerWidth,
                    inputHeigh: 60,
                    color: Colors.black45,
                    icon: Icons.email_outlined,
                    text: 'Saisissez votre email',
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 15),
                  InputPasswordWidget(
                    width: containerWidth,
                    height: 60,
                    icon: Icons.lock,
                    text: "Saisissez votre mot de passe",
                    color: Colors.black45,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Obx(() => Switch(
                                value: _switchValue.value,
                                onChanged: (value) {
                                  _switchValue.value = value;
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Colors.deepOrange,
                              )),
                          const Text("Se souvenir de moi"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _authController.login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      } catch (e) {
                        if (kDebugMode) {
                          print(e.toString());
                        }
                      }
                    },
                    child: const btnWidget(
                      inputWidth: 350,
                      inputHeigh: 60,
                      text: "SE CONNECTER",
                    ),
                  ),
                  const SizedBox(height: 50),
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
                  const SizedBox(height: 50),
                  SizedBox(
                    width: containerWidth - 40,
                    child: const SocialBtnWidget(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: screenHeight - 115,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: const Text("Vous n'avez pas de compte ?"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: const Text(
                        "Creer un compte",
                        style: TextStyle(color: Colors.orange),
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
