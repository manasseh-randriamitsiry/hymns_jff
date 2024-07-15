import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fihirana/utility/screen_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/hymn.dart';
import '../../services/hymn_service.dart';
import '../favorite/favorites_screen.dart';
import '../hymn/edit_hymn_screen.dart'; // Import your edit screen
import '../hymn/hymn_detail_screen.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  _AccueilScreenState createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  final TextEditingController _searchController = TextEditingController();
  final HymnService _hymnService = HymnService();
  List<Hymn> _hymns = [];
  List<Hymn> _filteredHymns = [];
  final Random _random = Random();

  bool isUserAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  String getUsername() {
    return FirebaseAuth.instance.currentUser?.displayName ?? 'Guest';
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

        _hymns.sort((a, b) {
          int numA = int.tryParse(a.hymnNumber) ?? 0;
          int numB = int.tryParse(b.hymnNumber) ?? 0;
          if (numA != numB) {
            return numA.compareTo(numB);
          } else {
            return a.title.compareTo(b.title);
          }
        });

        _filteredHymns = _hymns;
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
    if (isUserAuthenticated()) {
      await _hymnService.deleteHymn(hymn.id);
    } else {
      // Show a dialog to inform the user they must be logged in
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Action not allowed'),
            content: Text('You must be logged in to delete hymns.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _toggleFavorite(Hymn hymn) async {
    await _hymnService.toggleFavorite(hymn);
    setState(() {
      _filteredHymns = List.from(_filteredHymns);
    });
  }

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterHymns);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () {
            openDrawer(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Fihirana JFF',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Hitady hira',
                prefixIcon: const Icon(Icons.search),
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
                String firstVersePreview =
                    hymn.verses.isNotEmpty && hymn.verses.first.length > 30
                        ? '${hymn.verses.first.substring(0, 30)}...'
                        : (hymn.verses.isNotEmpty ? hymn.verses.first : '');

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Dismissible(
                    key: Key(hymn.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      if (isUserAuthenticated()) {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Hamafa',
                                style: TextStyle(
                                  color: getTextTheme(context),
                                ),
                              ),
                              content: Text('Manamafy fa hamafa ?',
                                  style: TextStyle(
                                    color: getTextTheme(context),
                                  )),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Tsia',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: getTextTheme(context),
                                      )),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Eny',
                                      style: TextStyle(
                                        color: getTextTheme(context),
                                      )),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Miala tsiny'),
                              content: Text(
                                  'Midira ho pikambana vao afaka manatanteraka.'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        return false;
                      }
                    },
                    onDismissed: (direction) {
                      _deleteHymn(hymn);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _getRandomColor().withOpacity(0.3),
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(firstVersePreview),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                hymn.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: hymn.isFavorite ? Colors.red : null,
                              ),
                              onPressed: () {
                                _toggleFavorite(hymn);
                              },
                            ),
                            if (isUserAuthenticated())
                              IconButton(
                                icon: const Icon(Icons.edit),
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
    if (isUserAuthenticated()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditHymnScreen(hymn: hymn),
        ),
      );
    } else {
      // Show a dialog to inform the user they must be logged in
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Miala tsiny'),
            content: Text('Midira ho pikambana vao afaka manatanteraka.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
