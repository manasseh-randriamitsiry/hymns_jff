import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permah_flutter/src/learn/utils/drawer.dart';
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;
    bool isDesktop = screenWidth >= 1200;
    double phoneScreenWidth = 12*screenWidth/13;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: IconButton(
                icon: const Icon(Icons.refresh),
              onPressed: (){
                if (kDebugMode) {
                  print("refreshed");
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  width: isDesktop ? 500 : phoneScreenWidth,
                  height: isDesktop ? 400 : screenHeigh / 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: Colors.blue.withOpacity(0.5),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      const Text("24 F",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow
                        ),
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: const Icon(
                            Icons.cloud_circle_outlined,
                            size: 100,
                            color: Colors.yellow,
                          ),
                      ),
                      const SizedBox(height: 10,),
                      const Text("Rainny",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        width: isDesktop ? 500 : phoneScreenWidth,
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "Weather forecast",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:20),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      forecast_widget(time: "7.0", lattitude: "Cloudy", icon: Icons.cloud, color: Colors.green),
                      SizedBox(width: 20),
                      forecast_widget(time: "8.0", lattitude: "off", icon: Icons.cloud_off, color: Colors.blue),
                      SizedBox(width: 20),
                      forecast_widget(time: "9.0", lattitude: "snowing", icon: Icons.cloudy_snowing, color: Colors.purpleAccent),
                      SizedBox(width: 20),
                      forecast_widget(time: "10.0", lattitude: "good", icon: Icons.wb_cloudy_outlined, color: Colors.black12),
                      SizedBox(width: 20),
                      forecast_widget(time: "11.0", lattitude: "sunny", icon: Icons.sunny, color: Colors.indigo),
                      SizedBox(width: 20),
                      forecast_widget(time: "12.0", lattitude: "snow", icon: Icons.ac_unit, color: Colors.deepPurple),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Container(
                        width: isDesktop ? 500 : phoneScreenWidth,
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "Additional information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.left,// S'assure que le texte est aligné à gauche
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:20),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      additionalWidget(icon: Icons.ac_unit_rounded,title: "humidity",time: "23",color: Colors.black),
                      SizedBox(width: 20),
                      additionalWidget(icon: Icons.wind_power,title: "windspeed",time: "345",color: Colors.black),
                      SizedBox(width: 20),
                      additionalWidget(icon: Icons.pregnant_woman_sharp,title: "pressure",time: "29",color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
    );
  }
}

class additionalWidget extends StatelessWidget {
  const additionalWidget({
    super.key, required this.time, required this.title, required this.icon, required this.color,
  });
  final String time;
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth/4,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: 50,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: color.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class forecast_widget extends StatelessWidget {
  const forecast_widget({
    super.key, required this.time, required this.lattitude, required this.icon, required this.color,
  });

  final String time;
  final String lattitude;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= 1200;
    double phoneScreenWidth = 12*screenWidth/13;
    return Container(
      width: isDesktop ? screenWidth / 10 : phoneScreenWidth / 5,
      height: isDesktop ? 100 : 100,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: color.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: 25,
              color: color,
            ),
          ),
          Text(
            lattitude,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
