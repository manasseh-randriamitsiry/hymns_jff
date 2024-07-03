import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortieScreen extends StatelessWidget {
  const SortieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight / 1.5,
            width: screenWidth,
            child: Image.asset(
              "assets/images/avatar-5.jpg",
              fit: BoxFit.cover,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderWidget(),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: screenWidth - 50,
                        height: 2,
                        color: Colors.grey.shade300,
                      ),
                      const InformationWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      const DescriptionWidget(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "International Band Music Concert",
                style: TextStyle(fontSize: 14),
              ),
              const Row(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.orange,
                          ),
                          Text(
                            " Chiconi Mayotte",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 12,
                            color: Colors.orange,
                          ),
                          Text(
                            " 15 Octobre à 12h00",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Membres 78/100",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(20, (index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.0),
                            child: Icon(
                              Icons.account_circle_rounded,
                              color: Colors.orange,
                              size: 20,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.orange.shade100),
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const SortieScreen());
                  },
                  child: const Text(
                    'REJOINDRE',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'GRATUIT',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.account_circle_rounded),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Tamim Ikram",
              style: TextStyle(),
            ),
          ],
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Icon(
                Icons.messenger,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: Icon(
                Icons.phone,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 50),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: Colors.grey.shade500, width: 2),
              ),
              child: const Icon(Icons.bookmark_border_outlined),
            ),
          ],
        ),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: const Text(
            "Le Concert International de Musique de Groupe est un événement annuel rassemblant des groupes du monde entier dans divers genres, de la pop au jazz. Cette année, il se tient dans une salle de concert emblématique, offrant une soirée de performances live, des stands de nourriture internationale, et des expositions d'art.",
            textAlign: TextAlign.justify,
          ),
        ),
        Column(
          children: [
            const Text(
              "Commentaire:",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: Colors.black.withOpacity(0.2)),
              ),
              child: const Center(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.black,
              ),
              child: const Text(
                "Envoyer votre commentaire",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: const Text("Pas de commentaire pour le moment"),
            ),
            Container(
              height: screenHeight / 2,
            )
          ],
        ),
      ],
    );
  }
}
