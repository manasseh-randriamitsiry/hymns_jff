import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/screen/sortie/sortie_screen.dart';

import '../../controller/BottomNavController.dart';
import '../../controller/accueil_controller.dart';
import '../../controller/horizontalScrollController.dart';

class AccueilScreen extends StatelessWidget {
  final AccueilController controller = Get.put(AccueilController());
  final BottomNavController navController = Get.put(BottomNavController());
  final HorizontalScrollController horizontalScrollController =
      Get.put(HorizontalScrollController());

  AccueilScreen({super.key});

  final List<Map<String, String>> events = [
    {
      'title': 'International Band Co',
      'date': '12 Avril 2025 à 12h',
      'location': 'Andrainjato',
      'member_count': '20/30',
      'image_url':
          'https://variety.com/wp-content/uploads/2023/06/avatar-1.jpg?w=1000',
    },
    {
      'title': 'Tech Conference 2024',
      'date': '15 Juillet 2024 à 09h',
      'location': 'Paris',
      'member_count': '50/100',
      'image_url':
          'https://cdn1.epicgames.com/offer/eca39884bdf14f65af242a8e3ff5b2d9/EGST_StoreLandscape_2560x1440_2560x1440-4207efea668639964f50064af970da15',
    },
    {
      'title': 'Art Exhibition',
      'date': '01 Décembre 2024 à 14h',
      'location': 'New York',
      'member_count': '80/150',
      'image_url':
          'https://cdn.vox-cdn.com/thumbor/OUz8LMwmB-DNdR1_vgdGN_iEsbY=/0x0:1200x800/1200x800/filters:focal(523x244:715x436)/cdn.vox-cdn.com/uploads/chorus_image/image/71772548/DChinAvatarSequel_20thCentury_Getty_Ringer.0.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildUserInfoSection(context),
            _buildEventCarousel(context),
            _buildMemberSection(context),
            _buildOnlineMemberSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bienvenue',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  )),
              Text(
                'MADI Ahmed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                'Position actuelle',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text('Mayotte, 97640',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventCarousel(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return CarouselSlider.builder(
      itemCount: events.length,
      options: CarouselOptions(
        height: screenHeight / 2,
        viewportFraction: 0.8,
        initialPage: 1,
        enableInfiniteScroll: true,
        autoPlay: false,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, index, realIndex) {
        double scaleFactor = 2;
        if (index == 0 || index == 2) {
          scaleFactor = 0.9;
        }
        return _buildEventSection(
          context,
          event: events[index],
          scaleFactor: scaleFactor,
        );
      },
    );
  }

  Widget _buildEventSection(BuildContext context,
      {required Map<String, String> event, double scaleFactor = 1.0}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = 4 * screenWidth / 5;
    double containerHeight = screenHeight / 3;

    return FractionallySizedBox(
      widthFactor: 0.9,
      child: EventsWidget(
        containerWidth: containerWidth,
        containerHeight: containerHeight,
        title: event['title']!,
        date: event['date']!,
        lieu: event['location']!,
        member_count: event['member_count']!,
        image_url: event['image_url']!,
      ),
    );
  }

  Widget _buildMemberSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Derniers membres',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  )),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentMembers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    _buildMemberItem(controller.recentMembers[index], context),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMemberItem(String name, BuildContext context) {
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

  Widget _buildOnlineMemberSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Membres en ligne',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  )),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: controller.onlineMembers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    _buildMemberItem(controller.onlineMembers[index], context),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventsWidget extends StatelessWidget {
  const EventsWidget({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
    required this.title,
    required this.date,
    required this.lieu,
    required this.member_count,
    required this.image_url,
  });

  final double containerWidth;
  final double containerHeight;
  final String title;
  final String date;
  final String lieu;
  final String member_count;
  final String image_url;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var backgroundColor = theme.chipTheme.backgroundColor;
    var textThemeColor = theme.textTheme.bodyLarge?.color;
    return Container(
      width: containerWidth,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 4)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: containerWidth / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const SortieScreen());
                    },
                    child: Image.network(
                      image_url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: containerWidth / 10,
                    height: containerHeight / 10,
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
          Text(
            title,
            style: TextStyle(fontSize: 20, color: textThemeColor),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: Colors.deepOrange,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                date,
                style: TextStyle(fontSize: 12, color: textThemeColor),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.location_on_sharp,
                color: Colors.deepOrange,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                lieu,
                style: TextStyle(fontSize: 12, color: textThemeColor),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_pin,
                      color: Colors.deepOrange,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "$member_count membres ont rejoint",
                      style: TextStyle(fontSize: 12, color: textThemeColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SortieScreen());
                  },
                  child: Container(
                    width: containerWidth / 4,
                    height: containerHeight / 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: const Center(
                      child: Text(
                        "Rejoindre",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
