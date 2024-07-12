import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permah_flutter/services/api_service.dart';

import '../../controller/BottomNavController.dart';
import '../../controller/accueil_controller.dart';
import '../../controller/horizontalScrollController.dart';
import '../../utility/screen_util.dart';
import '../../widgets/EventsWidget.dart';

class AccueilScreen extends StatefulWidget {
  AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final AccueilController controller = Get.put(AccueilController());

  final ApiService _apiService = Get.put(ApiService());

  final BottomNavController navController = Get.put(BottomNavController());

  final HorizontalScrollController horizontalScrollController =
      Get.put(HorizontalScrollController());

  String _username = "Anonymous";

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    String? username = await _apiService.getUsername();
    setState(() {
      _username = username!;
    });
  }

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
          GestureDetector(
            child: const CircleAvatar(
              radius: 30,
            ),
            onTap: () {
              openDrawer(context);
            },
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
                _username,
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
        viewportFraction: 0.9,
        initialPage: 1,
        enableInfiniteScroll: true,
        autoPlay: true,
        pauseAutoPlayOnTouch: true,
        autoPlayInterval: const Duration(seconds: 5),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        animateToClosest: true,
        enlargeFactor: BorderSide.strokeAlignOutside,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        pauseAutoPlayInFiniteScroll: true,
        pauseAutoPlayOnManualNavigate: true,
        autoPlayCurve: Curves.easeIn,
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
      {required Map<String, String> event, double scaleFactor = 2.0}) {
    return FractionallySizedBox(
      widthFactor: 0.92,
      child: EventsWidget(
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
