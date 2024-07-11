import 'package:flutter/foundation.dart';
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
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Réinitialiser le mot de passe",
          style: TextStyle(fontSize: 20, color: textColor),
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
                  Text(
                    "Veuillez entrer votre adresse email pour demander une reinitialisation de mot de passe ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor),
                  ),
                  const SizedBox(height: 50),
                  const InputWidget(
                    icon: Icons.email_outlined,
                    labelText: "Entrer votre adresse email",
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  BtnWidget(
                    onTap: () {
                      if (kDebugMode) {
                        print("Send email");
                      }
                      // Send email
                    },
                    inputWidth: containerWidth,
                    inputHeight: 60,
                    text: "ENVOYER",
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
