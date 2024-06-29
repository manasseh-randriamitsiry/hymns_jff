import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/sortie/sortie_screen.dart';

import '../../widgets/bottom_navigation_widget.dart';
import '../controllers/BottomNavController.dart';
import '../controllers/accueil_controller.dart';
import '../controllers/horizontalScrollController.dart';

class AccueilScreen extends StatelessWidget {
  final AccueilController controller = Get.put(AccueilController());
  final BottomNavController navController = Get.put(BottomNavController());
  final HorizontalScrollController horizontalScrollController =
      Get.put(HorizontalScrollController());

  AccueilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          child: _buildUserInfoSection(),
        ),
      ),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 120),
            _buildEventCarousel(),
            _buildMemberSection(),
            _buildOnlineMemberSection(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(navController),
    );
  }

  Widget _buildUserInfoSection() {
    return const Padding(
      padding: EdgeInsets.only(top: 30, left: 5, right: 5, bottom: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bienvenue', style: TextStyle(fontSize: 12)),
              Text(
                'MADI Ahmed',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text('Position actuelle'),
              Text('Mayotte, 97640'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventCarousel() {
    return CarouselSlider.builder(
      itemCount: 3, // Adjust based on the number of items
      options: CarouselOptions(
        height: 420,
        // Example height, adjust as needed
        viewportFraction: 0.8,
        initialPage: 1,
        enableInfiniteScroll: true,
        autoPlay: false,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
        double scaleFactor = 1.0;
        if (index == 0 || index == 2) {
          scaleFactor = 0.8;
        }
        return _buildEventSection(scaleFactor: scaleFactor);
      },
    );
  }

  Widget _buildEventSection({double scaleFactor = 1.0}) {
    return Container(
      width: 310,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 310,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => SortieScreen(),
                      );
                    },
                    child: Image.asset(
                      "assets/images/avatar-5.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "International Band Music Co.",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Colors.deepOrange,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "15 Octobre à 12h 30",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            children: [
              Icon(
                Icons.location_on_sharp,
                color: Colors.deepOrange,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "Chiconi, Mayotte",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(
                Icons.person_pin,
                color: Colors.deepOrange,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "Membres ont rejoint",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    print("rejoindre button clicked");
                  }
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 4)
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Rejoindre",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Derniers membres',
                  style: TextStyle(fontSize: 18, color: Colors.deepOrange)),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // Add padding to the list view for horizontal spacing
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentMembers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // Add horizontal spacing between items
                child: _buildMemberItem(controller.recentMembers[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMemberItem(String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          child: Icon(
            Icons.person,
            size: 20,
          ),
        ),
        Text(name),
      ],
    );
  }

  Widget _buildOnlineMemberSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Membres en ligne',
                  style: TextStyle(fontSize: 18, color: Colors.deepOrange)),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // Add padding to the list view for horizontal spacing
            scrollDirection: Axis.horizontal,
            itemCount: controller.onlineMembers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // Add horizontal spacing between items
                child: _buildMemberItem(controller.onlineMembers[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
