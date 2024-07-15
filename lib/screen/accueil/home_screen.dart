import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fihirana/screen/about/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../widgets/drawerWidget.dart';
import 'accueil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    AccueilScreen(),
    AboutScreen(),
  ];

  int _selectedIndex = 0;

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
    var theme = Theme.of(context);
    return ZoomDrawer(
      style: DrawerStyle.style4,
      mainScreenTapClose: true,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.65,
      moveMenuScreen: true,
      menuScreen: const DrawerScreen(),
      menuScreenOverlayColor: Colors.black,
      mainScreen: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 70,
          animationCurve: Curves.easeOutExpo,
          backgroundColor: Colors.transparent,
          color: theme.primaryColor,
          index: _selectedIndex,
          items: const [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.app_shortcut_outlined, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
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
