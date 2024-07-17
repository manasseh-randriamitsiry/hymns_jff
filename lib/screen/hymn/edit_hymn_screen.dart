import 'package:fihirana/utility/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/hymn.dart';
import '../../services/hymn_service.dart';

class EditHymnScreen extends StatefulWidget {
  final Hymn hymn;

  const EditHymnScreen({super.key, required this.hymn});

  @override
  _EditHymnScreenState createState() => _EditHymnScreenState();
}

class _EditHymnScreenState extends State<EditHymnScreen> {
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
    _bridgeController.text = widget.hymn.bridge ?? "";
    _hymnHintController.text = widget.hymn.hymnHint ?? "";

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

  Future<void> _saveChanges() async {
    // Check if the hymn number is unique
    bool isUnique = await _hymnService.isHymnNumberUnique(
        _hymnNumberController.text, widget.hymn.id);

    if (!isUnique) {
      Get.snackbar(
        'Nisy olana',
        'Antony : efa misy hira faha: ${_hymnNumberController.text} ',
        backgroundColor: Colors.yellowAccent.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.warning_amber, color: Colors.black),
      );
      return;
    }

    // Update the hymn object with new values
    Hymn updatedHymn = Hymn(
      id: widget.hymn.id,
      hymnNumber: _hymnNumberController.text,
      title: _titleController.text,
      verses: _verseControllers.map((controller) => controller.text).toList(),
      bridge: _bridgeController.text,
      hymnHint: _hymnHintController.text,
    );

    // Call your Firestore update method from the service
    try {
      await _hymnService.updateHymn(updatedHymn.id, updatedHymn);
      Navigator.pop(context); // Navigate back after update
    } catch (error) {
      print('Error updating hymn: $error');
      Get.snackbar(
        'Nisy olana',
        'Tsy tafiditra ny fanavaozana.',
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.black,
        icon: const Icon(Icons.error, color: Colors.black),
      );
    }
  }

  void _addVerse() {
    setState(() {
      _verseControllers.add(TextEditingController());
    });
  }

  void _reorderVerse(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    setState(() {
      final controller = _verseControllers.removeAt(oldIndex);
      _verseControllers.insert(newIndex, controller);
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
            onPressed: _saveChanges,
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
              const SizedBox(height: 10),
              ReorderableListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                onReorder: _reorderVerse,
                children: _buildVerseInputs(),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _addVerse,
                  child: const Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _bridgeController,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Fiverenana (Tsy voatery)',
                  prefixIcon: const Icon(Icons.refresh),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _hymnHintController,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Hymn Hint (Info, Tempo, Style, etc)',
                  prefixIcon: const Icon(Icons.info_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
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
          key: ValueKey('verse_$i'),
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            key: ValueKey(i),
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
              const SizedBox(width: 5),
              ReorderableDragStartListener(
                index: i,
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.move_up_rounded,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
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
