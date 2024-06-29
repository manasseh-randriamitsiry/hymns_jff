import 'package:flutter/material.dart';
import '../utils/drawer.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: Text('Messages Screen'),
      ),
      drawer: const DrawerScreen(),
    );
  }
}
