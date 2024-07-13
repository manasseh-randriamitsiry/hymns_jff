import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
  String _username = "Anonymous";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _themeController.isDarkMode.listen((isDarkMode) {
      _setSystemUiOverlayStyle(isDarkMode);
    });
  }

  /// Fetch the username from the API service
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

  /// Set the System UI Overlay Style based on the current theme
  void _setSystemUiOverlayStyle(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = _themeController.isDarkMode.value;
    _setSystemUiOverlayStyle(isDarkMode);

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
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: const Text(
              'this_is_you_email@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar-5.jpg'),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.brightness_6,
              color: Colors.white,
            ),
            title: const Text(
              'Change Theme',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              _themeController.toggleTheme();
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
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
