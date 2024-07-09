import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/auth/reset_pass_screen.dart';
import 'package:permah_flutter/screen/auth/signup_screen.dart';
import 'package:permah_flutter/widgets/btn_widget.dart';
import 'package:permah_flutter/widgets/input_password_widget.dart';
import 'package:permah_flutter/widgets/input_widget.dart';
import 'package:permah_flutter/widgets/social_btn_widget.dart';

import '../../controller/auth_controller.dart';
import '../../controller/theme_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ThemeController _themeController = Get.put(ThemeController());
  final _switchValue = false.obs;
  final _themeswitchValue = false.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final backgroundColor = theme.scaffoldBackgroundColor;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth - 50;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Connectez-vous",
          style: TextStyle(fontSize: 25, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          Obx(
            () => Switch(
              value: _themeswitchValue.value,
              onChanged: (value) {
                _themeswitchValue.value = value;
                _themeController.toggleTheme(); // Toggle the theme
              },
              activeColor: theme.colorScheme.secondary.withOpacity(0.5),
              activeTrackColor: theme.primaryColor.withOpacity(0.5),
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                (Set<WidgetState> states) {
                  if (_themeswitchValue.value) {
                    return const Icon(Icons.nights_stay_rounded,
                        color: Colors.blue, size: 18);
                  } else {
                    return const Icon(Icons.sunny,
                        color: Colors.orange, size: 18);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: containerWidth,
              child: Column(
                children: [
                  SizedBox(height: screenHeight / 20),
                  Text(
                    "Donner vos informations pour vous connecter à votre compte",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor),
                  ),
                  SizedBox(height: screenHeight / 40),
                  InputWidget(
                    icon: Icons.email_outlined,
                    labelText: 'Saisissez votre identifiant',
                    controller: _usernameController,
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  InputPasswordWidget(
                    lblText: "Saisissez votre mot de passe",
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Switch(
                              // this is not for the theme
                              value: _switchValue.value,
                              onChanged: (value) {},
                            ),
                          ),
                          Text("Se souvenir de moi",
                              style: TextStyle(color: textColor)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const ResetPassScreen());
                        },
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight / 20),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _authController.login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                        // for test ( ssl error )
                      } catch (e) {
                        if (kDebugMode) {
                          print(e.toString());
                        }
                      }
                    },
                    child: btnWidget(
                      inputWidth: containerWidth,
                      inputHeigh: screenHeight / 14,
                      text: "SE CONNECTER",
                    ),
                  ),
                  SizedBox(height: screenHeight / 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 2 * screenWidth / 8,
                        color: textColor.withOpacity(0.2),
                        height: 2,
                      ),
                      Text("ou continuer avec",
                          style: TextStyle(color: textColor)),
                      Container(
                        width: 2 * screenWidth / 8,
                        color: textColor.withOpacity(0.2),
                        height: 2,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight / 30),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Vous n'avez pas de compte ?",
                      style: TextStyle(color: textColor)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignupScreen(),
                          transition: Transition.rightToLeft);
                    },
                    child: Text(
                      "Creer un compte",
                      style: TextStyle(color: theme.primaryColor),
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
