import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.hintColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Fiangonana',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Jesosy Famonjena Fahamarinantsika',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  'Antsororokavo Fianarantsoa 301',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 20),
                Text(
                  'Mpamorona rindrambaiko',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 10),
                Text(
                  'Randriamitsiry Valimbavaka Nandrasana Manassé',
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  'Contact: +261 34 29 439 71',
                  style: TextStyle(color: textColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  'Adiresy: Ambalavao tsienimparihy',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  'Email: manassehrandriamitsiry@gmail.com',
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  'GitHub: https://github.com/manassehrandriamitsiry',
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  'App version : 0.1',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
