import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/hymn.dart';

class HymnDetailScreen extends StatefulWidget {
  final Hymn hymn;

  const HymnDetailScreen({super.key, required this.hymn});

  @override
  HymnDetailScreenState createState() => HymnDetailScreenState();
}

class HymnDetailScreenState extends State<HymnDetailScreen> {
  final double _baseFontSize = 16.0;
  final double _baseCountFontSize = 50.0;
  double _fontSize = 16.0;
  double _countFontSize = 50.0;
  double _scale = 1.0;
  double _previousScale = 1.0;
  final double _minFontSize = 10.0;

  List<Color> verseColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lime,
    Colors.cyan,
    Colors.brown,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('fontSize') ?? _baseFontSize;
      _countFontSize = _fontSize * (_baseCountFontSize / _baseFontSize);
      _scale = _fontSize / _baseFontSize;
    });
  }

  Future<void> _saveFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', _fontSize);
  }

  bool isUserAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          _previousScale = _scale;
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _scale = _previousScale * details.scale;
            _fontSize = _baseFontSize * _scale;
            if (_fontSize < _minFontSize) {
              _fontSize = _minFontSize;
              _scale = _fontSize / _baseFontSize;
            }
            _countFontSize = _baseCountFontSize * _scale;
          });
        },
        onScaleEnd: (ScaleEndDetails details) {
          _previousScale = 1.0;
          _saveFontSize();
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Text(
                        '${widget.hymn.hymnNumber} - ${widget.hymn.title}',
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.bold,
                          fontSize: _fontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.hymn.bridge != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15),
                  child: Text(
                    'Isan\'andininy:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15),
                  child: Text(
                    widget.hymn.bridge!,
                    style: TextStyle(
                        fontSize: _fontSize,
                        color: theme.textTheme.bodyLarge?.color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text(
                    'Andininy',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ],
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.hymn.verses.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.15,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${i + 1}',
                                      style: TextStyle(
                                        fontSize: _countFontSize,
                                        fontWeight: FontWeight.bold,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text(
                                  '${i + 1}. ${widget.hymn.verses[i]}',
                                  style: TextStyle(
                                    fontSize: _fontSize,
                                    color:
                                        verseColors[i % verseColors.length],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 100), // Adjust as needed
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "-- tapitra --",
                          style: TextStyle(
                            color: theme.textTheme.bodyLarge?.color,
                            fontSize: _fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
