import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/accueil/accueil_screen.dart';
import 'package:permah_flutter/services/api_service.dart';

import '../controller/auth_controller.dart';
import '../controller/theme_controller.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final AuthController _authController = Get.put(AuthController());
  final ApiService apiService = Get.put(ApiService());
  final ThemeController _themeController = Get.put(ThemeController());
  String _username = "Loading...";

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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            accountEmail: Text(
              'this_is_you_email@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar-5.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            title: Text(
              'Explorer',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            onTap: () {
              Get.to(AccueilScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.brightness_6,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            title: Text(
              'Change Theme',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            onTap: () {
              _themeController.toggleTheme();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            onTap: () {
              _authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
