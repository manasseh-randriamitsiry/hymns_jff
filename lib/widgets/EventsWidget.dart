import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/sortie/sortie_screen.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({
    super.key,
    required this.title,
    required this.date,
    required this.lieu,
    required this.member_count,
    required this.image_url,
  });

  final String title;
  final String date;
  final String lieu;
  final String member_count;
  final String image_url;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var backgroundColor = theme.dividerColor.withOpacity(0.8);
    var boxShadowColor = theme.hintColor.withOpacity(0.8);
    var textThemeColor = theme.textTheme.bodyLarge?.color;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = 4 * screenWidth / 5;
    double containerHeight = screenHeight / 3;

    return SingleChildScrollView(
      child: Container(
        width: containerWidth,
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(color: boxShadowColor.withOpacity(0.3), blurRadius: 4)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: containerHeight / 2,
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
      ),
    );
  }
}
