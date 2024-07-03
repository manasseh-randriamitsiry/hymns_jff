import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/user/edit_profile_screen.dart';

class ProfilPageScreen extends StatelessWidget {
  const ProfilPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const EditProfileScreen());
              },
              icon: const Icon(Icons.edit))
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'MADI Ahmed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(label: Text('Membre du staff')),
                SizedBox(width: 10),
                Chip(label: Text('Référent sportif')),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('1,089', 'Matchs'),
                _buildStatColumn('275', 'Abonnés'),
                _buildStatColumn('10', 'Entraînements'),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'A propos de moi\nPassionné de football et de découverte, je me définis comme un explorateur du monde et des cultures. Mon parcours m\'a amené à voyager dans différents pays, enrichissant ma vision du football et de la vie. Aujourd\'hui, je partage mon expérience en tant qu\'entraîneur, cherchant toujours à inspirer et à motiver les jeunes talents.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Centre d\'intérêt',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _buildInterestChip(Icons.music_note, 'Musique'),
                _buildInterestChip(Icons.flight, 'Voyage'),
                _buildInterestChip(Icons.palette, 'Culture'),
                _buildInterestChip(Icons.sports_soccer, 'Sport'),
                _buildInterestChip(Icons.spa, 'Zen'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildInterestChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: Colors.grey[200],
    );
  }
}
