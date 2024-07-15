import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fihirana/utility/screen_util.dart';
import 'package:flutter/material.dart';

import '../../models/hymn.dart';
import '../../services/hymn_service.dart';
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
                doc as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();

        // Sort hymns by hymnNumber or title
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
    await _hymnService.deleteHymn(hymn.id);
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
        title: const Text('Fihirana JFF'),
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

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _getRandomColor().withOpacity(0.1),
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
                          title: Text(hymn.title),
                          subtitle: Text(firstVersePreview),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _navigateToEditScreen(context, hymn);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _confirmDelete(context, hymn);
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
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, Hymn hymn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellowAccent.withOpacity(0.5),
          title: Text(
            'Hamafa',
            style: TextStyle(
              color: getTextTheme(context),
            ),
          ),
          content: Text('Manaiky fa hamafa ?',
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eny',
                  style: TextStyle(
                    color: getTextTheme(context),
                  )),
              onPressed: () {
                _deleteHymn(hymn);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
