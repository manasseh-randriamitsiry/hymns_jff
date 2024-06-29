import 'package:flutter/material.dart';
import 'package:permah_flutter/src/learn/converter/currency_converter.dart';
import 'package:permah_flutter/src/learn/weather/weather_screen.dart';

import '../home/home_screen_view.dart';
import '../widgets/new_navigate_to_page.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= 1200;
    return Drawer(
      width: isDesktop ? 300 : (4 * screenWidth / 5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Manasseh',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              'manassehrandriamitsiry@gmail.com',
              style: TextStyle(color: Colors.black),
            ),
            decoration: BoxDecoration(color: Colors.transparent),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar-5.jpg'),
            ),
          ),
          NavigateToPage(
            icon: Icons.home_rounded,
            text: "Home",
            route: HomeScreen(),
            backgroundColor: Colors.blue,
          ),
          NavigateToPage(
            icon: Icons.cloud,
            text: "Weather",
            route: WeatherScreen(),
            backgroundColor: Colors.green,
          ),
          NavigateToPage(
            icon: Icons.currency_exchange,
            text: "Converter",
            route: CurrencyConverter(),
            backgroundColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}
