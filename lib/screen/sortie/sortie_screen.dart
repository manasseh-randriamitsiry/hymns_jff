import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortieScreen extends StatelessWidget {
  SortieScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 300,
              width: screenWidth,
              color: Colors.deepPurple,
              child: Image.asset(
                "assets/images/avatar-5.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 250,
              child: Container(
                height: screenHeight,
                // Adjusted height to avoid overlap
                width: screenWidth,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderWidget(),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: screenWidth - 50,
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                    InformationWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    DescriptionWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "International Band Music Concert",
                  style: TextStyle(fontSize: 14),
                ),
                Container(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Row(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Row(
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Membres 78/100",
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 100,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(20, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
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
        ),
        Container(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.orange.shade100),
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => SortieScreen());
                  },
                  child: Text(
                    'REJOINDRE',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
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
  const InformationWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.account_circle_rounded),
                backgroundColor: Colors.grey.shade200,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Tamim Ikram",
                style: TextStyle(),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.messenger,
                  color: Colors.black.withOpacity(0.6),
                ),
                backgroundColor: Colors.grey.shade200,
              ),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.phone,
                  color: Colors.black.withOpacity(0.6),
                ),
                backgroundColor: Colors.grey.shade200,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.grey.shade500, width: 2),
                ),
                child: Icon(Icons.bookmark_border_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            "Le Concert International de Musique de Groupe est un événement annuel rassemblant des groupes du monde entier dans divers genres, de la pop au jazz. Cette année, il se tient dans une salle de concert emblématique, offrant une soirée de performances live, des stands de nourriture internationale, et des expositions d'art.",
            textAlign: TextAlign.justify,
          ),
        ),
        Container(
          child: Column(
            children: [
              Text(
                "Commentaire:",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.black),
                ),
              ),
              Container(
                child: Text(
                  "Envoyer votre commentaire",
                  style: TextStyle(color: Colors.white),
                ),
                padding:
                    EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text("Pas de commentaire pour le moment"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
