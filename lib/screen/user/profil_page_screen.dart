import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/user/edit_profile_screen.dart';
import 'package:permah_flutter/utility/screen_util.dart';

import '../../services/api_service.dart';
import '../../services/notification_service.dart';

class ProfilPageScreen extends StatefulWidget {
  const ProfilPageScreen({super.key});

  @override
  State<ProfilPageScreen> createState() => _ProfilPageScreenState();
}

class _ProfilPageScreenState extends State<ProfilPageScreen> {
  @override
  final ApiService _apiService = Get.put(ApiService());
  String _username = "Anonymous";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    String? username = await _apiService.getUsername();
    setState(() {
      _username = username!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    var backgroundColor = theme.chipTheme.backgroundColor;
    var textThemeColor = theme.textTheme.bodyLarge?.color;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: textColor,
          ),
          onPressed: () {
            openDrawer(context);
          },
        ),
        title: Text(
          'Profil',
          style: TextStyle(color: textThemeColor),
        ),
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
                GestureDetector(
                  onTap: () {
                    NotificationService.showSuccessNotification(
                      'Hello',
                      'From profile_page_screen',
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                  ),
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
            Text(
              _username,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textThemeColor),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  label: Text(
                    'Membre du staff',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  backgroundColor: backgroundColor,
                ),
                const SizedBox(width: 10),
                Chip(
                  label: Text(
                    'Référent sportif',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  backgroundColor: backgroundColor,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('1,089', 'Matchs', context),
                _buildStatColumn('275', 'Abonnés', context),
                _buildStatColumn('10', 'Entraînements', context),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '\tA propos de moi: passionné de football et de découverte, je me définis comme un explorateur du monde et des cultures. Mon parcours m\'a amené à voyager dans différents pays, enrichissant ma vision du football et de la vie. Aujourd\'hui, je partage mon expérience en tant qu\'entraîneur, cherchant toujours à inspirer et à motiver les jeunes talents.',
                textAlign: TextAlign.justify,
                style: TextStyle(color: textThemeColor),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Centre d\'intérêt',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textThemeColor),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _buildInterestChip(Icons.music_note, 'Musique', context),
                _buildInterestChip(Icons.flight, 'Voyage', context),
                _buildInterestChip(Icons.palette, 'Culture', context),
                _buildInterestChip(Icons.sports_soccer, 'Sport', context),
                _buildInterestChip(Icons.spa, 'Zen', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            )),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildInterestChip(IconData icon, String label, BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).dividerColor,
        ),
      ),
      backgroundColor: Theme.of(context).textTheme.bodyLarge?.color,
    );
  }
}
