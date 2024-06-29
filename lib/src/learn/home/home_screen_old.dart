import 'package:flutter/material.dart';

class HomeScreenOld extends StatefulWidget {
  const HomeScreenOld({super.key});

  @override
  State<HomeScreenOld> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenOld> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 1.0 : 1.0)
        ..rotateZ(isDrawerOpen ? 10 * -3.14159265358979323846 / 180 : 0),
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
          borderRadius: isDrawerOpen ? BorderRadius.circular(50) : BorderRadius.circular(0),
          color: Colors.white
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenHeigh/20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth/12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isDrawerOpen ? GestureDetector(
                    child: const Icon(Icons.arrow_back),
                    onTap: (){
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        isDrawerOpen = false;
                      });
                    },
                  ): GestureDetector(
                    child: const Icon(Icons.menu),
                    onTap: (){
                      setState(() {
                        xOffset = 290;
                        yOffset = 80;
                        isDrawerOpen = true;
                      });
                    },
                  ),
                  const Text('My drawer',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  Container(),
                ],
              ),
            ),
            SizedBox(
              height: screenHeigh/20,
            ),
            Column(
              children: <Widget>[
                const NewWidgetLine(
                  imageLeft: 'assets/images/coming-soon.png',
                  textLeft: 'image left 1',
                  imageRight: 'assets/images/login-img.png',
                  textRight: 'text right 1',
                ),
                SizedBox(
                  height: screenHeigh/10,
                ),
                const NewWidgetLine(
                  imageLeft: 'assets/images/login-img.png',
                  textLeft: 'image left 2',
                  imageRight: 'assets/images/login-img.png',
                  textRight: 'text right 2',
                ),
                SizedBox(
                  height: screenHeigh/10,
                ),
                const NewWidgetLine(
                  imageLeft: 'assets/images/coming-soon.png',
                  textLeft: 'image left 3',
                  imageRight: 'assets/images/login-img.png',
                  textRight: 'text right 3',
                ),
                SizedBox(
                  height: screenHeigh/10,
                ),
                const NewWidgetLine(
                  imageLeft: 'assets/images/login-img.png',
                  textLeft: 'image left 4',
                  imageRight: 'assets/images/login-img.png',
                  textRight: 'text right 4',
                ),
                SizedBox(
                  height: screenHeigh/10,
                ),
                const NewWidgetLine(
                  imageLeft: 'assets/images/login-img.png',
                  textLeft: 'image left 4',
                  imageRight: 'assets/images/login-img.png',
                  textRight: 'text right 4',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewWidgetLine extends StatelessWidget {
  final String imageLeft;
  final String textLeft;
  final String imageRight;
  final String textRight;

  const NewWidgetLine({
    super.key, required this.imageLeft, required this.textLeft, required this.imageRight, required this.textRight,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;
    bool isDesktop = screenWidth >= 1200;

    double boxWidth = isDesktop ? screenWidth / 3 : screenWidth / 2.8;
    double boxHeight = isDesktop ? screenHeigh/2 : screenHeigh/5;
    return Padding(padding: EdgeInsets.symmetric(horizontal: boxWidth/8,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width:boxWidth,
            height: boxHeight, // Reduced height to prevent overflow
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image(
                    image: AssetImage(imageLeft),
                    fit: BoxFit.cover,
                    height: boxHeight/1.5,
                    width: boxWidth,
                  ),
                ),
                Text(
                  textLeft,
                  style: const TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
          Container(
            width:boxWidth,
            height: boxHeight, // Reduced height to prevent overflow
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image(
                    image: AssetImage(imageRight),
                    fit: BoxFit.cover,
                    height: boxHeight/1.5,
                    width: boxWidth,
                  ),
                ),
                Text(
                  textRight,
                  style: const TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: Colors.black
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
