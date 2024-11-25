import 'package:fihirana/controller/hymnController.dart';
import 'package:fihirana/utility/screen_util.dart';
import 'package:flutter/material.dart';
import '../../services/hymn_service.dart';

class CreateHymnPage extends StatefulWidget {
  const CreateHymnPage({super.key});

  @override
  CreateHymnPageState createState() => CreateHymnPageState();
}

class CreateHymnPageState extends State<CreateHymnPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _versesController = TextEditingController();
  final TextEditingController _bridgeController = TextEditingController();
  final TextEditingController _hymnNumberController = TextEditingController();
  final TextEditingController _hymnHintController = TextEditingController();

  List<TextEditingController> _verseControllers = [];
  final HymnController _hymnController = HymnController();

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
    _hymnHintController.dispose();
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
                // Make verses draggable with ReorderableListView
                ReorderableListView(
                  shrinkWrap: true,
                  onReorder: _onReorder,
                  children: _buildVerseInputs(),
                ),
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
                    labelText: 'Isan\'andininy (Raha misy)',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _hymnHintController,
                  maxLines: null, // Allow multiple lines for bridge
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Naoty",
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
        ListTile(
          key: ValueKey(i), // Unique key for reordering
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.drag_handle),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: TextFormField(
              controller: _verseControllers[i],
              maxLines: null, // Allow multiple lines for verses
              decoration: InputDecoration(
                labelText: 'Andininy: ${i + 1}',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Soraty eto ny andininy ${i + 1}';
                }
                return null;
              },
            ),
          ),
          trailing: _verseControllers.length > 1
              ? CircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _verseControllers.removeAt(i);
                      });
                    },
                  ),
                )
              : null,
        ),
      );
    }
    return verseInputs;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final controller = _verseControllers.removeAt(oldIndex);
      _verseControllers.insert(newIndex, controller);
    });
  }

  Future<void> _createHymn() async {
    try {
      final hymnNumber = _hymnNumberController.text.trim();
      final title = _titleController.text.trim();
      final verses = _verseControllers
          .map((controller) => controller.text.trim())
          .toList();
      final bridge = _bridgeController.text.isNotEmpty
          ? _bridgeController.text.trim()
          : null;
      final hymnHint = _hymnHintController.text.isNotEmpty
          ? _bridgeController.text.trim()
          : null;

      if (await _hymnController.createHymn(
          hymnNumber, title, verses, bridge, hymnHint)) {
        // Clear controllers and reset state after successful creation
        _hymnNumberController.clear();
        _titleController.clear();
        for (var controller in _verseControllers) {
          controller.clear();
        }
        _bridgeController.clear();
        _hymnHintController.clear(); // Clear hymn hint controller

        setState(() {
          _verseControllers = [TextEditingController()];
        });
      }
    } catch (error) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nisy olana fa ialana tsiny: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
