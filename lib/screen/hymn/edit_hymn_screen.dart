import 'package:fihirana/utility/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/hymn.dart';
import '../../services/hymn_service.dart';

class EditHymnScreen extends StatefulWidget {
  final Hymn hymn;

  const EditHymnScreen({super.key, required this.hymn});

  @override
  EditHymnScreenState createState() => EditHymnScreenState();
}

class EditHymnScreenState extends State<EditHymnScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _hymnNumberController = TextEditingController();
  final TextEditingController _bridgeController = TextEditingController();
  final TextEditingController _hymnHintController = TextEditingController();
  List<TextEditingController> _verseControllers = [];

  final HymnService _hymnService = HymnService();

  @override
  void initState() {
    super.initState();
    _hymnNumberController.text = widget.hymn.hymnNumber.toString();
    _titleController.text = widget.hymn.title;
    _hymnHintController.text = widget.hymn.hymnHint ?? "";
    _bridgeController.text = widget.hymn.bridge ?? "";

    // Initialize verse controllers and populate them with existing verses
    _verseControllers = widget.hymn.verses
        .map((verse) => TextEditingController(text: verse))
        .toList();
  }

  @override
  void dispose() {
    _hymnNumberController.dispose();
    _titleController.dispose();
    _bridgeController.dispose();
    _hymnHintController.dispose();
    for (var controller in _verseControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveChanges() {
    // Update the hymn object with new values
    Hymn updatedHymn = Hymn(
        id: widget.hymn.id,
        hymnNumber: _hymnNumberController.text,
        title: _titleController.text,
        verses: _verseControllers.map((controller) => controller.text).toList(),
        bridge: _bridgeController.text,
        hymnHint: _hymnHintController.text);

    // Call your Firestore update method from the service
    _hymnService
        .updateHymn(updatedHymn.id, updatedHymn) // Pass the id and updatedHymn
        .then((_) {
      Navigator.pop(context); // Navigate back after update
    }).catchError((error) {
      if (kDebugMode) {
        print('Error updating hymn: $error');
      }
      // Handle error as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hanova ny hira faha: ${widget.hymn.hymnNumber}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveChanges();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _hymnNumberController,
                decoration: InputDecoration(
                  labelText: 'Laharan\'ny hira',
                  prefixIcon: const Icon(Icons.onetwothree_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Lohateny',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Andininy',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: getTextTheme(context),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ..._buildVerseInputs(),
              const SizedBox(height: 16.0),
              TextField(
                controller: _bridgeController,
                minLines: 10,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Fiverenana (Tsy voatery)',
                  prefixIcon: const Icon(Icons.refresh),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              TextField(
                controller: _hymnHintController,
                minLines: 5,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Naoty',
                  prefixIcon: const Icon(Icons.note_alt_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _saveChanges();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 40.0, right: 40, top: 20, bottom: 20),
                    child: Text(
                      "Apidiro",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildVerseInputs() {
    List<Widget> verseInputs = [];
    for (int i = 0; i < _verseControllers.length; i++) {
      verseInputs.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _verseControllers[i],
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Andininy: ${i + 1}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (_verseControllers.length > 1)
                CircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _verseControllers.removeAt(i);
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return verseInputs;
  }
}
