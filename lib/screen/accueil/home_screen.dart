import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fihirana/screen/about/about_screen.dart';
import 'package:fihirana/widgets/drawer_wiidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import 'accueil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const AccueilScreen(),
    const AboutScreen(),
  ];

  final int _selectedIndex = 0;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return ZoomDrawer(
      style: DrawerStyle.style4,
      mainScreenTapClose: true,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.64,
      moveMenuScreen: true,
      menuScreen: const DrawerScreen(),
      menuScreenOverlayColor: Colors.black,
      mainScreen: Scaffold(
        body: _screens[_selectedIndex],
      ),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
}
