import 'package:cached_network_image/cached_network_image.dart';
import 'package:fihirana/screen/about/about_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/theme_controller.dart';
import '../screen/favorite/favorites_screen.dart';
import '../screen/hymn/create_hymn_page.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  DrawerScreenState createState() => DrawerScreenState();
}

class DrawerScreenState extends State<DrawerScreen> {
  final ThemeController _themeController = Get.put(ThemeController());
  bool _isAuthenticated = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInAccount? _currentUser;

  void _checkAuthStatus() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _updateCurrentUser();
      } else {
        setState(() {
          _isAuthenticated = false;
          _currentUser = null;
        });
      }
    });
  }

  void _updateCurrentUser() async {
    GoogleSignInAccount? account = _googleSignIn.currentUser;
    if (account == null && _firebaseAuth.currentUser != null) {
      account = await _googleSignIn.signInSilently();
    }
    setState(() {
      _isAuthenticated = _firebaseAuth.currentUser != null;
      _currentUser = account;
    });
  }

  void _setSystemUiOverlayStyle(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
  }

  Future<void> _signInWithGoogle() async {
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
        _updateCurrentUser();
        Get.snackbar('Tongasoa', 'Tafiditra ianao.',
            backgroundColor: Colors.green.withOpacity(0.2),
            colorText: Colors.black,
            icon: const Icon(Icons.check, color: Colors.black));
      }
    } catch (e) {
      Get.snackbar('Nisy olana: $e', 'fa avereno atao.',
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: Colors.black,
          icon: const Icon(Icons.warning_amber, color: Colors.black));
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    _themeController.isDarkMode.listen((isDarkMode) {
      _setSystemUiOverlayStyle(isDarkMode);
    });
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
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
          if (_currentUser == null)
            const SizedBox(
              height: 50,
            ),
          if (_currentUser != null)
            UserAccountsDrawerHeader(
              accountName: Text(_currentUser!.displayName ?? ''),
              accountEmail: Text(_currentUser!.email),
              currentAccountPicture: CachedNetworkImage(
                imageUrl: _currentUser!.photoUrl ?? '',
                // Assuming _currentUser has a photoUrl property
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
              leading: Icon(Icons.add, color: getTextTheme(context)),
              title: Text(
                'Hapiditra hira',
                style: TextStyle(color: getTextTheme(context)),
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
                setState(() {
                  _isAuthenticated = false;
                  _currentUser = null;
                });
              },
            ),
          ListTile(
            leading: Icon(Icons.info_outline, color: getTextTheme(context)),
            title: Text(
              '?',
              style: TextStyle(color: getTextTheme(context)),
            ),
            onTap: () {
              Get.to(const AboutScreen());
            },
          ),
        ],
      ),
    );
  }
}

Color getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
}
