import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fihirana/utility/screen_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/hymn.dart';
import '../../services/hymn_service.dart';
import '../favorite/favorites_screen.dart';
import '../hymn/edit_hymn_screen.dart';
import '../hymn/hymn_detail_screen.dart';
import 'package:local_auth/local_auth.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  AccueilScreenState createState() => AccueilScreenState();
}

class AccueilScreenState extends State<AccueilScreen> {
  final TextEditingController _searchController = TextEditingController();
  final HymnService _hymnService = HymnService();
  final LocalAuthentication auth = LocalAuthentication();
  List<Hymn> _hymns = [];
  List<Hymn> _filteredHymns = [];
  final Random _random = Random();
  Hymn? _selectedHymn;
  bool _isLoading = true;

  bool isUserAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  String getUsername() {
    return FirebaseAuth.instance.currentUser?.displayName ??
        'Jesosy Famonjena Fahamarinantsika';
  }

  @override
  void initState() {
    super.initState();
    _fetchHymns();
    _searchController.addListener(_filterHymns);
  }

  void _fetchHymns() {
    _hymnService.getHymnsStream().listen((QuerySnapshot snapshot) {
      setState(() {
        _hymns = snapshot.docs
            .map((doc) => Hymn.fromFirestore(
                doc as DocumentSnapshot<Map<String, dynamic>>))
            .toList();
        _isLoading = false;
        _hymns.sort((a, b) {
          int numA = int.tryParse(a.hymnNumber) ?? 0;
          int numB = int.tryParse(b.hymnNumber) ?? 0;
          if (numA != numB) {
            return numA.compareTo(numB);
          } else {
            _isLoading = false;
            return a.title.compareTo(b.title);
          }
        });
        _filteredHymns = _hymns;
        _isLoading = false;
      });
    });
  }

  void _filterHymns() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredHymns = _hymns
          .where((hymn) =>
              hymn.hymnNumber.toLowerCase().contains(query) ||
              hymn.title.toLowerCase().contains(query) ||
              hymn.verses.any((verse) => verse.toLowerCase().contains(query)))
          .toList();
    });
  }

  Future<void> _deleteHymn(Hymn hymn) async {
    bool authenticated = false;
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isBiometricSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics && isBiometricSupported) {
        authenticated = await auth.authenticate(
          localizedReason:
              'Ampidiro ny rantsan-tànanao hanamafisana ny famafana.',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
      } else {
        authenticated = await auth.authenticate(
          localizedReason:
              'Ilaina ny rantsan-tànanao, endrikao, na tenimiafinao hanamafisana ny famafana.',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ),
        );
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Authentication error: $e');
      }
    }

    if (authenticated) {
      await _hymnService.deleteHymn(hymn.id);
      showSnackbarSuccessMessage(title: "Voafafa", message: "soamantsara");
    } else {
      showSnackbarErrorMessage(
          title: 'Filazana', message: 'Tsy manana fahefana ianao.');
    }
  }

  Future<void> _toggleFavorite(Hymn hymn) async {
    await _hymnService.toggleFavorite(hymn);
    setState(() {
      _filteredHymns = List.from(_filteredHymns);
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterHymns);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool tablet = isTablet(context);
    final theme = Theme.of(context);
    final appBarColor = theme.dividerColor;
    final textColor = theme.hintColor;
    if (tablet) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 0, // Remove elevation
          scrolledUnderElevation: 0,
          leading: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: textColor,
                ),
                onPressed: () {
                  openDrawer(context);
                },
              ),
            ],
          ),
          centerTitle: true,
          title: Text(
            'Fihirana JFF',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: textColor),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: textColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
              },
            ),
            // IconButton(
            //   icon:
            //       Icon(_isTabletMode ? Icons.tablet_android : Icons.smartphone),
            //   onPressed: () {
            //     setState(() {
            //       _isTabletMode = !_isTabletMode;
            //     });
            //   },
            // ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      'mahandrasa kely azafady',
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ), // Show loading indicator
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 10,
                  ),
                  Container(
                    height: getScreenHeight(context) -
                        getScreenHeight(context) / 12,
                    width: (getScreenWidth(context) / 3) - 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: textColor.withOpacity(0.1),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              fillColor: textColor,
                              labelText: 'Hitady hira',
                              prefixIcon: Icon(
                                Icons.search,
                                color: textColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onChanged: (value) {
                              _filterHymns();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _filteredHymns.length,
                            itemBuilder: (context, index) {
                              final hymn = _filteredHymns[index];
                              String firstVersePreview = hymn
                                          .verses.isNotEmpty &&
                                      hymn.verses.first.length > 30
                                  ? '${hymn.verses.first.substring(0, 30)}...'
                                  : (hymn.verses.isNotEmpty
                                      ? hymn.verses.first
                                      : '');

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Dismissible(
                                  key: Key(hymn.id),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Icon(Icons.delete, color: textColor),
                                  ),
                                  confirmDismiss: (direction) async {
                                    bool confirm = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Hamafa',
                                            style: TextStyle(color: textColor),
                                          ),
                                          content: Text(
                                            'Manamafy fa hamafa ?',
                                            style: TextStyle(color: textColor),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                'Tsia',
                                                style:
                                                    TextStyle(color: textColor),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'Eny',
                                                style:
                                                    TextStyle(color: textColor),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (confirm) {
                                      await _deleteHymn(hymn);
                                    }
                                    return false; // Prevent auto-dismissal
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: textColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Text(
                                          hymn.hymnNumber,
                                          style: TextStyle(
                                            color: getTextTheme(context),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        hymn.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        firstVersePreview,
                                        style: TextStyle(color: textColor),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              hymn.isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: hymn.isFavorite
                                                  ? Colors.red
                                                  : textColor,
                                            ),
                                            onPressed: () {
                                              _toggleFavorite(hymn);
                                            },
                                          ),
                                          if (isUserAuthenticated())
                                            IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: textColor,
                                              ),
                                              onPressed: () {
                                                _navigateToEditScreen(
                                                    context, hymn);
                                              },
                                            ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _selectedHymn = hymn;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Text(
                          getUsername(),
                        ),
                      ],
                    ),
                  ),
                  if (_selectedHymn == null)
                    SizedBox(
                      height: getScreenHeight(context),
                      width: (2 * getScreenWidth(context) / 3) - 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Salamo 118:29",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                          Text(
                            "Miderà an'i Jehovah, fa tsara Izy; Eny, mandrakizay ny famindram-pony.",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_selectedHymn != null)
                    SizedBox(
                      height: getScreenHeight(context),
                      width: (2 * getScreenWidth(context) / 3) - 10,
                      child: HymnDetailScreen(hymn: _selectedHymn!),
                    ),
                ],
              ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0, // Remove elevation
        scrolledUnderElevation: 0,
        title: Text(
          'Hiran\'ny fihirana',
          style: TextStyle(color: textColor),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.ac_unit,
            color: textColor,
          ),
          onPressed: () {
            openDrawer(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text(
                    'mahandrasa kely azafady',
                    style: TextStyle(color: textColor),
                  ),
                ],
              ), // Show loading indicator
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Hitady hira',
                      labelStyle: TextStyle(color: textColor),
                      hintStyle: TextStyle(color: textColor),
                      prefixIcon: Icon(
                        Icons.search,
                        color: textColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            color: textColor), // Add border color here
                      ),
                      enabledBorder: OutlineInputBorder(
                        // Add enabledBorder
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: textColor), // Same border color
                      ),
                    ),
                    onChanged: (value) {
                      _filterHymns();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredHymns.length,
                    itemBuilder: (context, index) {
                      final hymn = _filteredHymns[index];
                      String firstVersePreview = hymn.verses.isNotEmpty &&
                              hymn.verses.first.length > 30
                          ? '${hymn.verses.first.substring(0, 30)}...'
                          : (hymn.verses.isNotEmpty ? hymn.verses.first : '');

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Dismissible(
                          key: Key(hymn.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.delete,
                              color: textColor,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            bool confirm = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Hamafa',
                                    style: TextStyle(color: textColor),
                                  ),
                                  content: Text(
                                    'Manamafy fa hamafa ?',
                                    style: TextStyle(color: textColor),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Tsia',
                                        style: TextStyle(color: textColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Eny',
                                        style: TextStyle(color: textColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            if (confirm) {
                              await _deleteHymn(hymn);
                            }
                            return false; // Prevent auto-dismissal
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: textColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  hymn.hymnNumber,
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                hymn.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor),
                              ),
                              subtitle: Text(
                                firstVersePreview,
                                style: TextStyle(color: textColor),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      hymn.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          hymn.isFavorite ? Colors.red : textColor,
                                    ),
                                    onPressed: () {
                                      _toggleFavorite(hymn);
                                    },
                                  ),
                                  if (isUserAuthenticated())
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: textColor,
                                      ),
                                      onPressed: () {
                                        _navigateToEditScreen(context, hymn);
                                      },
                                    ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HymnDetailScreen(hymn: hymn),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  getUsername(),
                ),
              ],
            ),
    );
  }

  void _navigateToEditScreen(BuildContext context, Hymn hymn) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditHymnScreen(hymn: hymn),
      ),
    );
  }
}
