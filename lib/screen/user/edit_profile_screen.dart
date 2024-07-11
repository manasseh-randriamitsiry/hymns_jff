import 'package:flutter/material.dart';

import '../../widgets/btn_widget.dart';
import '../../widgets/input_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double inputHeight = screenHeight / 10;
    double containerWidth = screenWidth - 50;

    final TextEditingController idController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController nextNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController dateOfBirthController = TextEditingController();
    final TextEditingController adressController = TextEditingController();
    final TextEditingController ciController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Modifier le profil',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.hintColor,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: textColor, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: containerWidth / 2,
                  height: inputHeight,
                  child: InputWidget(
                    icon: Icons.perm_identity_outlined,
                    labelText: 'Identifiant',
                    type: TextInputType.text,
                    controller: idController,
                  ),
                ),
                SizedBox(
                  width: containerWidth / 2,
                  height: inputHeight,
                  child: InputWidget(
                    icon: Icons.person,
                    labelText: 'Nom',
                    type: TextInputType.name,
                    controller: usernameController,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: containerWidth / 2,
              height: inputHeight,
              child: InputWidget(
                  icon: Icons.arrow_forward_ios,
                  labelText: 'Prenom',
                  type: TextInputType.text,
                  controller: nextNameController),
            ),
            SizedBox(
              width: containerWidth / 2,
              height: inputHeight,
              child: InputWidget(
                  icon: Icons.email,
                  labelText: 'Email',
                  type: TextInputType.emailAddress,
                  controller: emailController),
            ),
            SizedBox(
              width: containerWidth / 2,
              height: inputHeight,
              child: InputWidget(
                icon: Icons.date_range_outlined,
                labelText: 'Date de naissance',
                type: TextInputType.datetime,
                controller: dateOfBirthController,
              ),
            ),
            SizedBox(
              width: containerWidth / 2,
              height: inputHeight,
              child: InputWidget(
                icon: Icons.location_on,
                labelText: 'Adresse',
                type: TextInputType.streetAddress,
                controller: adressController,
              ),
            ),
            SizedBox(
              width: containerWidth / 2,
              height: inputHeight,
              child: InputWidget(
                  icon: Icons.phone,
                  labelText: 'Téléphone',
                  type: TextInputType.phone,
                  controller: phoneNumberController),
            ),
            SizedBox(
              width: containerWidth / 2,
              height: inputHeight,
              child: InputWidget(
                icon: Icons.interests_outlined,
                labelText: "Centre d'interet",
                type: TextInputType.multiline,
                controller: ciController,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text('Offre particulier Gratuit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textColor)),
                ),
                Text(
                  'Abonnement premium\n4,99€/mois',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 24),
            BtnWidget(
              onTap: () {
                // Save data
              },
              inputWidth: 350,
              inputHeight: 60,
              text: "ENREGISTRER",
            ),
          ],
        ),
      ),
    );
  }
}
