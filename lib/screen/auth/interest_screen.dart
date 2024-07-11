import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widgets/btn_widget.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth - 50;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // No app bar, just a transparent space
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sélectionnez vos centres d\'intérêt',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: screenHeight - 350,
              child: const InterestGrid(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Récupérer les éléments sélectionnés
                List<String> selectedInterests =
                    InterestGridState.selectedInterests;
                if (kDebugMode) {
                  print("Éléments sélectionnés : $selectedInterests");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: BtnWidget(
                onTap: () {
                  // Récupérer les éléments sélectionnés
                  List<String> selectedInterests =
                      InterestGridState.selectedInterests;
                  if (kDebugMode) {
                    print("Éléments sélectionnés : $selectedInterests");
                  }
                },
                inputWidth: containerWidth - 50,
                inputHeight: 50,
                text: "SUIVANT",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterestGrid extends StatefulWidget {
  const InterestGrid({super.key});

  @override
  InterestGridState createState() => InterestGridState();
}

class InterestGridState extends State<InterestGrid> {
  static List<String> selectedInterests = [];

  final List<Map<String, dynamic>> interests = [
    {'icon': Icons.theater_comedy, 'label': 'Théâtre'},
    {'icon': Icons.music_note, 'label': 'Musique'},
    {'icon': Icons.volunteer_activism, 'label': 'Bénévolat'},
    {'icon': Icons.sports_soccer, 'label': 'Sport'},
    {'icon': Icons.restaurant, 'label': 'Nourriture'},
    {'icon': Icons.airplanemode_active, 'label': 'Voyage'},
  ];

  void toggleSelection(String label) {
    setState(() {
      if (selectedInterests.contains(label)) {
        selectedInterests.remove(label);
      } else {
        selectedInterests.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemCount: interests.length,
      itemBuilder: (context, index) {
        String label = interests[index]['label'];
        bool isSelected = selectedInterests.contains(label);

        return GestureDetector(
          onTap: () => toggleSelection(label),
          child: InterestCard(
            icon: interests[index]['icon'],
            label: label,
            isSelected: isSelected,
          ),
        );
      },
    );
  }
}

class InterestCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const InterestCard(
      {super.key,
      required this.icon,
      required this.label,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 2,
        ),
      ),
      elevation: 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.blue : Colors.black.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
