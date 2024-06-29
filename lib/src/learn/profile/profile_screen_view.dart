import 'package:flutter/material.dart';
import '../utils/drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
      drawer: const DrawerScreen(),
    );
  }
}
