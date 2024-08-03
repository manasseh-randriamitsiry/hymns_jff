import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

const googleFontsAPI =
    'https://www.googleapis.com/webfonts/v1/webfonts?key=AIzaSyC-ak88TTqiGpT7hyZV9hOnSQhu0n9A7hU';

class FontSelectionPage extends StatefulWidget {
  @override
  _FontSelectionPageState createState() => _FontSelectionPageState();
}

class _FontSelectionPageState extends State<FontSelectionPage> {
  List<String> fonts = [];

  @override
  void initState() {
    super.initState();
    fetchFonts();
  }

  Future<void> fetchFonts() async {
    try {
      final response = await http.get(Uri.parse(googleFontsAPI));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = data['items'] as List;
        setState(() {
          fonts = items.map((e) => e['family'].toString()).toList();
        });
      } else {
        throw Exception('Failed to load fonts');
      }
    } catch (e) {
      print('Error fetching fonts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Font'),
      ),
      body: ListView.builder(
        itemCount: fonts.length,
        itemBuilder: (context, index) {
          final font = fonts[index];
          return ListTile(
            title: Text(font),
            onTap: () {
              downloadAndCacheFonts(font);
              Navigator.pop(context, font); // Pass selected font back
            },
          );
        },
      ),
    );
  }

  Future<void> downloadAndCacheFonts(String fontName) async {
    try {
      final response =
          await http.get(Uri.parse('$googleFontsAPI&family=$fontName'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final files = data['items'][0]['files'] as Map<String, dynamic>;
        await downloadAndSaveFont(files['regular'], '$fontName-Regular.ttf');
        await downloadAndSaveFont(files['italic'], '$fontName-Italic.ttf');
        // Add more variants as needed
        print('Fonts downloaded and cached for $fontName');
      } else {
        throw Exception('Failed to fetch font details for $fontName');
      }
    } catch (e) {
      print('Error downloading fonts: $e');
    }
  }

  Future<void> downloadAndSaveFont(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final fontFile = File('${dir.path}/$filename');
    await fontFile.writeAsBytes(bytes);
    // Optionally, you can store the file path in SharedPreferences or similar
  }
}
