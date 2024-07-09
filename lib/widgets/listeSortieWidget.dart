import 'package:flutter/material.dart';

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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Row(
                children: [
                  Text(
                    dateLeft,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    dateRight,
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            width: 1,
            height: screenHeight / 20,
            margin: const EdgeInsets.all(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                location,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                occupied,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                "REJOINDRE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
