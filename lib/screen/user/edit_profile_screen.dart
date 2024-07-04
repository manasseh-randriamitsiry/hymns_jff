import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme
    final textColor =
        theme.textTheme.bodyLarge?.color ?? Colors.black; // Dynamic text color
    final borderColor = theme.dividerColor; // Dynamic border color
    final backgroundColor =
        theme.scaffoldBackgroundColor; // Dynamic background color for container
    final buttonColor = theme.colorScheme.primary; // Dynamic button color

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Modifier le profil',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    backgroundColor: backgroundColor,
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
              children: [
                Expanded(
                    child: _buildRoundedInput(
                        label: 'H',
                        borderColor: borderColor,
                        textColor: textColor)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildRoundedInput(
                        label: 'F',
                        borderColor: borderColor,
                        textColor: textColor)),
              ],
            ),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: 'Identifiant',
                borderColor: borderColor,
                textColor: textColor),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: 'E-mail',
                borderColor: borderColor,
                textColor: textColor),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildRoundedInput(
                        label: 'Nom',
                        borderColor: borderColor,
                        textColor: textColor)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildRoundedInput(
                        label: 'Prénom',
                        borderColor: borderColor,
                        textColor: textColor)),
              ],
            ),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: 'Date de naissance',
                trailing: Icons.calendar_today,
                borderColor: borderColor,
                textColor: textColor),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: 'Adresse',
                trailing: Icons.location_on,
                borderColor: borderColor,
                textColor: textColor),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: "Centre d'intérêt: Culture Musique Sports",
                trailing: Icons.arrow_drop_down,
                borderColor: borderColor,
                textColor: textColor),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: 'Téléphone',
                trailing: Icons.phone,
                borderColor: borderColor,
                textColor: textColor),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(
                  child: Text('Offre particulier Gratuit',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text('Abonnement premium\n4,99€/mois',
                    textAlign: TextAlign.right),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text('ENREGISTRER', style: TextStyle(color: textColor)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedInput(
      {required String label,
      IconData? trailing,
      required Color borderColor,
      required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: textColor), // Dynamic label text color
          border: InputBorder.none,
          suffixIcon:
              trailing != null ? Icon(trailing, color: textColor) : null,
        ),
      ),
    );
  }
}
