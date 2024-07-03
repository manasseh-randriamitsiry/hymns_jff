import 'dart:math'; // Add this import for random number generation

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/BottomNavController.dart';

class ListeSortieScreen extends StatefulWidget {
  const ListeSortieScreen({super.key});

  @override
  _ListeSortieScreenState createState() => _ListeSortieScreenState();
}

class _ListeSortieScreenState extends State<ListeSortieScreen> {
  List<String> filterOptions = ['Sports', 'Music', 'Food', 'Travel', 'Gaming'];
  List<String> selectedFilters = [];

  // List of events
  List<Map<String, String>> sorties = [
    {
      'title': 'Soiree FIFA',
      'time': '12h à 18H',
      'dateLeft': '07 Octobre',
      'dateRight': 'Sada Mayotte',
      'location': 'MALIKI',
      'occupied': '5/10',
      'category': 'Gaming',
    },
    {
      'title': 'Concert de Jazz',
      'time': '20h à 23H',
      'dateLeft': '10 Octobre',
      'dateRight': 'Mamoudzou',
      'location': 'Jazz Club',
      'occupied': '30/50',
      'category': 'Music',
    },
    {
      'title': 'Course de Marathon',
      'time': '08h à 12H',
      'dateLeft': '15 Octobre',
      'dateRight': 'Petite-Terre',
      'location': 'Stade Municipal',
      'occupied': '20/100',
      'category': 'Sports',
    },
  ];

  // List to hold random colors for each event
  List<Color> eventColors = [];

  @override
  void initState() {
    super.initState();
    // Generate random colors when the widget is initialized
    generateRandomColors();
  }

  // Method to generate a random color
  void generateRandomColors() {
    final random = Random();
    eventColors = List.generate(sorties.length, (index) {
      return Color.fromARGB(
        200,
        random.nextInt(256), // Random value for red
        random.nextInt(256), // Random value for green
        random.nextInt(256), // Random value for blue
      );
    });
  }

  void _openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: filterOptions,
      selectedListData: selectedFilters,
      choiceChipLabel: (item) => item,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (filter, query) {
        return filter.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedFilters = List.from(list ?? []);
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List<Map<String, String>> filteredSorties = sorties.where((sortie) {
      if (selectedFilters.isEmpty) {
        return true;
      }
      return selectedFilters.contains(sortie['category']);
    }).toList();
    final BottomNavController navController = Get.put(BottomNavController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evenements'),
        actions: [
          IconButton(
            onPressed: _openFilterDialog,
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListItemsTop(),
            Container(
              margin: const EdgeInsets.all(20),
              height: screenHeight / 10,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Trouver une sortie",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.08)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            ...filteredSorties.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> sortie = entry.value;
              return ListSortieWidget(
                screenHeight: screenHeight,
                backgroundColor: eventColors[index],
                // Use the random color here
                icon: Icons.event,
                title: sortie['title']!,
                time: sortie['time']!,
                dateLeft: sortie['dateLeft']!,
                dateRight: sortie['dateRight']!,
                location: sortie['location']!,
                occupied: sortie['occupied']!,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ListSortieWidget extends StatelessWidget {
  const ListSortieWidget({
    super.key,
    required this.screenHeight,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    required this.time,
    required this.location,
    required this.occupied,
    required this.dateLeft,
    required this.dateRight,
  });

  final double screenHeight;
  final Color backgroundColor;
  final IconData icon;
  final String title;
  final String time;
  final String dateLeft;
  final String dateRight;
  final String location;
  final String occupied;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 12),
              ),
              Row(
                children: [
                  Text(
                    dateLeft,
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    dateRight,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          Container(
            color: Colors.black45,
            width: 1,
            height: screenHeight / 20,
            margin: const EdgeInsets.all(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                location,
                style: const TextStyle(fontSize: 10),
              ),
              Text(
                occupied,
                style: const TextStyle(fontSize: 10),
              ),
              const Text(
                "REJOINDRE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListItemsTop extends StatelessWidget {
  const ListItemsTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.refresh,
            size: 40,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              color: Colors.black.withOpacity(0.07),
            ),
            child: const Icon(
              Icons.security,
              size: 15,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              color: Colors.black.withOpacity(0.07),
            ),
            child: const Icon(
              Icons.sports_basketball_sharp,
              size: 15,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              color: Colors.black.withOpacity(0.07),
            ),
            child: const Icon(
              Icons.music_note_outlined,
              size: 15,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              color: Colors.black.withOpacity(0.07),
            ),
            child: const Icon(
              Icons.flight_takeoff_rounded,
              size: 15,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              color: Colors.black.withOpacity(0.07),
            ),
            child: const Icon(
              Icons.local_dining_outlined,
              size: 15,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter_none,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
