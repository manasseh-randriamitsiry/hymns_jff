import 'package:flutter/material.dart';

import '../../models/hymn.dart'; // Import your hymn model
import '../../services/hymn_service.dart'; // Import your Firestore service

class EditHymnScreen extends StatefulWidget {
  final Hymn hymn;

  const EditHymnScreen({Key? key, required this.hymn}) : super(key: key);

  @override
  _EditHymnScreenState createState() => _EditHymnScreenState();
}

class _EditHymnScreenState extends State<EditHymnScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _hymnNumberController = TextEditingController();
  final TextEditingController _versesController = TextEditingController();
  final TextEditingController _bridgeController = TextEditingController();

  final HymnService _hymnService =
      HymnService(); // Initialize your Firestore service

  @override
  void initState() {
    super.initState();
    _hymnNumberController.text = widget.hymn.hymnNumber.toString();
    _titleController.text = widget.hymn.title;
    _versesController.text = widget.hymn.verses.join("\n");
    _bridgeController.text = widget.hymn.bridge ?? "";
  }

  @override
  void dispose() {
    _hymnNumberController.dispose();
    _titleController.dispose();
    _versesController.dispose();
    _bridgeController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Update the hymn object with new values
    Hymn updatedHymn = Hymn(
      id: widget.hymn.id,
      hymnNumber: _hymnNumberController.text,
      title: _titleController.text,
      verses: _versesController.text.split("\n"),
      bridge: _bridgeController.text,
    );

    // Call your Firestore update method from the service
    _hymnService
        .updateHymn(updatedHymn.id!, updatedHymn) // Pass the id and updatedHymn
        .then((_) {
      Navigator.pop(context); // Navigate back after update
    }).catchError((error) {
      print('Error updating hymn: $error');
      // Handle error as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hanova ny hira faha: ${widget.hymn.hymnNumber}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveChanges();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _hymnNumberController,
                  decoration: InputDecoration(
                    labelText: 'Laharan\'ny hira',
                    prefixIcon: Icon(Icons.onetwothree_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Lohateny',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _versesController,
                  minLines: 4,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Andininy ( ' , ' = midinana andalana )",
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _bridgeController,
                  minLines: 2,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Fiverenana (Tsy voatery)',
                    prefixIcon: Icon(Icons.refresh),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _saveChanges();
                    },
                    child: Text("Apidiro"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
