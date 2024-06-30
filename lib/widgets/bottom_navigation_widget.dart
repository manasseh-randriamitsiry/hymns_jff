// bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/BottomNavController.dart';

Widget buildBottomNavigationBar(BottomNavController navController) {
  return Obx(() => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_rounded),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: navController.selectedIndex.value,
        backgroundColor: Colors.yellow,
        selectedItemColor: Colors.orange,
        selectedFontSize: 12,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          navController.changeIndex(index);
        },
      ));
}
