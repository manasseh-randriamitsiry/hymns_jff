import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            const Text('Modifier le profil', style: TextStyle(color: Colors.black)),
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
                    backgroundColor: Colors.grey[200],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildRoundedInput(label: 'H')),
                const SizedBox(width: 16),
                Expanded(child: _buildRoundedInput(label: 'F')),
              ],
            ),
            const SizedBox(height: 16),
            _buildRoundedInput(label: 'Identifiant'),
            const SizedBox(height: 16),
            _buildRoundedInput(label: 'E-mail'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildRoundedInput(label: 'Nom')),
                const SizedBox(width: 16),
                Expanded(child: _buildRoundedInput(label: 'Prénom')),
              ],
            ),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: 'Date de naissance', trailing: Icons.calendar_today),
            const SizedBox(height: 16),
            _buildRoundedInput(label: 'Adresse', trailing: Icons.location_on),
            const SizedBox(height: 16),
            _buildRoundedInput(
                label: "Centre d'intérêt: Culture Musique Sports",
                trailing: Icons.arrow_drop_down),
            const SizedBox(height: 16),
            _buildRoundedInput(label: 'Téléphone', trailing: Icons.phone),
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
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text('ENREGISTRER'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedInput({required String label, IconData? trailing}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          suffixIcon: trailing != null ? Icon(trailing) : null,
        ),
      ),
    );
  }
}
