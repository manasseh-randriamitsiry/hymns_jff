import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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

  bool _showSlider = false; // Initially hidden
  bool _show = false;
  void _showFontSizeDialog(BuildContext context) {
    setState(() {
      _showSlider = !_showSlider;
    });
  }

  void _switchValue(BuildContext context) {
    setState(() {
      _show = !_show;
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.hymn.hymnNumber,
          maxLines: null,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
          ),
        ),
        centerTitle: true,
        actions: [
          if (widget.hymn.hymnHint!.trim().toLowerCase().isNotEmpty ??
              false) ...[
            IconButton(
              onPressed: () {
                _switchValue(context);
              },
              icon: const Icon(Icons
                  .remove_red_eye), // New icon for opening font size adjustment dialog
            ),
          ],
          IconButton(
            onPressed: () {
              _showFontSizeDialog(context);
            },
            icon: const Icon(Icons
                .text_fields), // New icon for opening font size adjustment dialog
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showSlider)
              Container(
                child: SfSlider(
                  min: 10.0,
                  max: 100.0,
                  interval: 5,
                  showTicks: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    _saveFontSize();
                    setState(() {
                      _fontSize = value;
                    });
                  },
                  onChangeEnd: (dynamic value) {
                    setState(() {
                      _showSlider = false; // Hide the slider on release
                    });
                  },
                  value: _fontSize,
                ),
              ),
            Center(
              child: Text(
                widget.hymn.title,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: _fontSize,
                ),
              ),
            ),
            if (_show == true &&
                    widget.hymn.hymnHint!.trim().toLowerCase().isNotEmpty ??
                false) ...[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  'Naoty:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  widget.hymn.hymnHint ?? '', // safely use hymnHint
                  style: TextStyle(
                    fontSize: 2 * _fontSize / 3,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ],
            if (widget.hymn.bridge != null &&
                widget.hymn.bridge!.trim().toLowerCase().isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Text(
                  'Isan\'andininy:',
                  style: TextStyle(
                    fontSize: _fontSize + 2,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
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
                    fontSize: _fontSize + 2,
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
                                  color: verseColors[i % verseColors.length],
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
    );
  }
}
