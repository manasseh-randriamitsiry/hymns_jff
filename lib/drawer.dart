import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/accueil/accueil_screen.dart';
import 'package:permah_flutter/services/api_service.dart';

import 'controller/auth_controller.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final AuthController _authController = Get.put(AuthController());
  final ApiService apiService = Get.put(ApiService());

  String _username = "Loading..."; // Initial value for username

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    String? username = await apiService.getUsername();
    if (username != null) {
      setState(() {
        _username = username;
      });
    } else {
      apiService.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= 1200;
    return Drawer(
      width: isDesktop ? 300 : (4 * screenWidth / 5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              _username,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            accountEmail: const Text(
              'this_is_you_email@gmail.com',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar-5.jpg'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Explorer'),
            onTap: () {
              Get.to(AccueilScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Changer Theme'),
            onTap: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Deconnecter'),
            onTap: () {
              _authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
