import 'package:fihirana/utility/screen_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/theme_controller.dart';
import '../screen/favorite/favorites_screen.dart';
import '../screen/hymn/create_hymn_page.dart';
import '../services/google_auth_service.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final ThemeController _themeController = Get.put(ThemeController());
  final String _username = "Anonymous";
  bool _isAuthenticated = false;
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    _themeController.isDarkMode.listen((isDarkMode) {
      _setSystemUiOverlayStyle(isDarkMode);
    });
  }

  void _checkAuthStatus() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _isAuthenticated = user != null;
      });
    });
  }

  void _setSystemUiOverlayStyle(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Get.snackbar('Success', 'You are logged in.',
            backgroundColor: Colors.green.withOpacity(0.2),
            colorText: Colors.black,
            icon: const Icon(Icons.check, color: Colors.black));
      }
    } catch (e) {
      Get.snackbar('An error occurred: ${e}', 'Try again.',
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.black,
          icon: const Icon(Icons.warning_amber, color: Colors.black));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = _themeController.isDarkMode.value;
    _setSystemUiOverlayStyle(isDarkMode);

    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= 1200;
    return Drawer(
      width: isDesktop ? 300 : (4 * screenWidth / 5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Fihirana JFF',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: getTextTheme(context)),
            ),
            accountEmail: Text(
              'manassehrandriamitsiry@gmail.com',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: getTextTheme(context)),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar-5.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.brightness_6, color: getTextTheme(context)),
            title: Text(
              'Hanova loko',
              style: TextStyle(color: getTextTheme(context)),
            ),
            onTap: () {
              _themeController.toggleTheme();
            },
          ),
          if (_isAuthenticated)
            ListTile(
              leading: Icon(Icons.logout, color: getTextTheme(context)),
              title: Text(
                'Mivoaka',
                style: TextStyle(
                  color: getTextTheme(context),
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          if (!_isAuthenticated)
            ListTile(
              leading: Icon(Icons.login, color: getTextTheme(context)),
              title: Text(
                'Miditra',
                style: TextStyle(color: getTextTheme(context)),
              ),
              onTap: () {
                _signInWithGoogle();
              },
            ),
          if (_isAuthenticated)
            ListTile(
              leading: Icon(
                Icons.add,
                color: Colors
                    .black, // Assuming getTextTheme(context) returns color
              ),
              title: Text(
                'Hapiditra hira',
                style: TextStyle(
                  color: Colors
                      .black, // Assuming getTextTheme(context) returns color
                ),
              ),
              onTap: () {
                Get.to(const CreateHymnPage());
              },
            ),
          ListTile(
            leading: Icon(Icons.favorite, color: getTextTheme(context)),
            title: Text(
              'Tiana',
              style: TextStyle(color: getTextTheme(context)),
            ),
            onTap: () {
              Get.to(FavoritesPage());
            },
          ),
        ],
      ),
    );
  }
}
