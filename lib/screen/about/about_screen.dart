import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('?'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Fiangonana',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Jesosy Famonjena Fahamarinantsika',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  'Antsororokavo Fianarantsoa 301',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  'Contact: +123 456 7890',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Mpamorona rindrambaiko',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Randriamitsiry Valimbavaka Nandrasana Manassé',
                ),
                SizedBox(height: 5),
                Text(
                  'Contact: +261 34 29 439 71',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Email: manassehrandriamitsiry@gmail.com',
                ),
                SizedBox(height: 5),
                Text(
                  'GitHub: https://github.com/manassehrandriamitsiry',
                ),
                SizedBox(height: 5),
                Text(
                  'App version : 1.0',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
