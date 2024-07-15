import 'package:fihirana/utility/screen_util.dart';
import 'package:flutter/material.dart';

import '../../models/hymn.dart';
import '../../services/hymn_service.dart';

class CreateHymnPage extends StatefulWidget {
  const CreateHymnPage({super.key});

  @override
  _CreateHymnPageState createState() => _CreateHymnPageState();
}

class _CreateHymnPageState extends State<CreateHymnPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _versesController = TextEditingController();
  final TextEditingController _bridgeController = TextEditingController();
  final TextEditingController _hymnNumberController = TextEditingController();

  List<TextEditingController> _verseControllers = [];

  final HymnService _hymnService = HymnService();

  @override
  void initState() {
    super.initState();
    _verseControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    _hymnNumberController.dispose();
    _titleController.dispose();
    _versesController.dispose();
    _bridgeController.dispose();
    for (var controller in _verseControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mampiditra hira'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _hymnNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Laharana',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Apidiro ny laharan'ny hira";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Lohateny',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Soraty ny lohateny';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Tonony',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: getTextTheme(context),
                  ),
                ),
                ..._buildVerseInputs(),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _verseControllers.add(TextEditingController());
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _bridgeController,
                  maxLines: null, // Allow multiple lines for bridge
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Fiverenena (Raha misy fiverenana)',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createHymn();
                    }
                  },
                  child: const Text('Apidiro'),
                ),
              ],
            ),
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
                child: TextFormField(
                  controller: _verseControllers[i],
                  maxLines: null, // Allow multiple lines for verses
                  decoration: InputDecoration(
                    labelText: 'Tonony: ${i + 1}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Soraty eto ny tonony ${i + 1}';
                    }
                    return null;
                  },
                ),
              ),
              if (_verseControllers.length > 1)
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      _verseControllers.removeAt(i);
                    });
                  },
                ),
            ],
          ),
        ),
      );
    }
    return verseInputs;
  }

  void _createHymn() {
    String hymnNumber = _hymnNumberController.text.trim();
    String title = _titleController.text.trim();
    List<String> verses =
        _verseControllers.map((controller) => controller.text.trim()).toList();
    String? bridge = _bridgeController.text.isNotEmpty
        ? _bridgeController.text.trim()
        : null;

    Hymn newHymn = Hymn(
      id: '',
      title: title,
      verses: verses,
      bridge: bridge,
      hymnNumber: hymnNumber,
    );

    _hymnService.addHymn(newHymn).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Tafiditra soamantsara'),
      ));
      // Clear form after submission
      _hymnNumberController.clear();
      _titleController.clear();
      for (var controller in _verseControllers) {
        controller.clear();
      }
      _bridgeController.clear();
      setState(() {
        _verseControllers = [TextEditingController()]; // Reset to initial state
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Nisy olana fa ialana tsiny: $error'),
        backgroundColor: Colors.red,
      ));
    });
  }
}
