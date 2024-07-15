import 'package:fihirana/utility/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/theme_controller.dart';
import '../screen/hymn/create_hymn_page.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final ThemeController _themeController = Get.put(ThemeController());
  final String _username = "Anonymous";

  @override
  void initState() {
    super.initState();
    _themeController.isDarkMode.listen((isDarkMode) {
      _setSystemUiOverlayStyle(isDarkMode);
    });
  }

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
              'Fihirana JFF',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getTextTheme(context),
              ),
            ),
            accountEmail: Text(
              'manassehrandriamitsiry@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getTextTheme(context),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar-5.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.brightness_6,
              color: getTextTheme(context),
            ),
            title: Text(
              'Hanova loko',
              style: TextStyle(
                color: getTextTheme(context),
              ),
            ),
            onTap: () {
              _themeController.toggleTheme();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              color: getTextTheme(context),
            ),
            title: Text(
              'Hapiditra hira',
              style: TextStyle(
                color: getTextTheme(context),
              ),
            ),
            onTap: () {
              Get.to(const CreateHymnPage());
            },
          ),
        ],
      ),
    );
  }
}
