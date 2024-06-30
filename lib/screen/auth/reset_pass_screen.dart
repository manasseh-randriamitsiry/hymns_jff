import 'package:flutter/material.dart';
import 'package:permah_flutter/widgets/input_widget.dart';

import '../../widgets/btn_widget.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<ResetPassScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth - 50;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Réinitialiser le mot de passe",
          style: TextStyle(fontSize: 20),
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
                  const SizedBox(height: 50),
                  const Text(
                    "Veuillez entrer votre adresse email pour demander une reinitialisation de mot de passe ",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  const InputWidget(
                    icon: Icons.email_outlined,
                    labelText: "Entrer votre adresse email",
                    color: Colors.black45,
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ResetPassScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: btnWidget(
                      inputWidth: containerWidth,
                      inputHeigh: 60,
                      text: "ENVOYER",
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
