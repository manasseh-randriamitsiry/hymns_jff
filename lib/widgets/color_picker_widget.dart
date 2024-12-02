import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../controller/color_controller.dart';

class ColorPickerWidget extends StatelessWidget {
  final ColorController colorController = Get.find<ColorController>();

  ColorPickerWidget({super.key});

  MaterialColor _getMaterialColor(Color color) {
    if (color == Colors.purple) return Colors.purple;
    if (color == Colors.deepOrange) return Colors.deepOrange;
    if (color == Colors.blue) return Colors.blue;
    if (color == Colors.amber) return Colors.amber;
    if (color == Colors.teal) return Colors.teal;
    if (color == Colors.pink) return Colors.pink;
    if (color == Colors.indigo) return Colors.indigo;
    if (color == Colors.orange) return Colors.orange;
    if (color == Colors.red) return Colors.red;
    if (color == Colors.green) return Colors.green;
    if (color == Colors.lime) return Colors.lime;
    if (color == Colors.yellow) return Colors.yellow;
    if (color == Colors.cyan) return Colors.cyan;
    if (color == Colors.brown) return Colors.brown;
    if (color == Colors.grey) return Colors.grey;
    return Colors.purple; // Default fallback
  }

  void _showColorPicker(BuildContext context, String colorType, Color currentColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Misafidy loko $colorType'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                if (colorType == 'fototra' || colorType == 'fanampin\'') {
                  // For primary and accent colors, convert to MaterialColor
                  final materialColor = _getMaterialColor(color);
                  onColorChanged(materialColor);
                } else {
                  // For other colors, use the color directly
                  onColorChanged(color);
                }
              },
              availableColors: colorType == 'fototra' || colorType == 'fanampin\''
                  ? [
                      // Material colors for primary and accent
                      Colors.purple,
                      Colors.deepOrange,
                      Colors.blue,
                      Colors.amber,
                      Colors.teal,
                      Colors.pink,
                      Colors.indigo,
                      Colors.orange,
                      Colors.red,
                      Colors.green,
                      Colors.lime,
                      Colors.yellow,
                      Colors.cyan,
                      Colors.brown,
                      Colors.grey,
                    ]
                  : [
                      // Colors for text and other UI elements
                      Colors.black,
                      Colors.white,
                      Colors.grey.shade900,
                      Colors.grey.shade800,
                      Colors.grey.shade700,
                      Colors.grey.shade600,
                      Colors.grey.shade500,
                      Colors.grey.shade400,
                      Colors.grey.shade300,
                      Colors.grey.shade200,
                      Colors.grey.shade100,
                      Colors.purple,
                      Colors.deepOrange,
                      Colors.blue,
                      Colors.amber,
                      Colors.teal,
                      Colors.pink,
                      Colors.indigo,
                      Colors.orange,
                      Colors.red,
                      Colors.green,
                    ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ekena'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorSchemePresets() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorController.colorSchemes.length,
        itemBuilder: (context, index) {
          final scheme = colorController.colorSchemes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () => colorController.applyColorScheme(index),
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      scheme['primary']!,
                      scheme['accent']!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Endrika voafidy mialoha',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        _buildColorSchemePresets(),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Loko manokana',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(() => ListTile(
          title: const Text('Loko fototra'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorController.primaryColor.value,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          onTap: () => _showColorPicker(
            context,
            'fototra',
            colorController.primaryColor.value,
            (color) => colorController.updateColors(primary: color),
          ),
        )),
        Obx(() => ListTile(
          title: const Text('Loko fanampin\''),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorController.accentColor.value,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          onTap: () => _showColorPicker(
            context,
            'fanampin\'',
            colorController.accentColor.value,
            (color) => colorController.updateColors(accent: color),
          ),
        )),
        Obx(() => ListTile(
          title: const Text('Lokon\'ny soratra'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorController.textColor.value,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          onTap: () => _showColorPicker(
            context,
            'soratra',
            colorController.textColor.value,
            (color) => colorController.updateColors(text: color),
          ),
        )),
        Obx(() => ListTile(
          title: const Text('Lokon\'ny ambadika'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorController.backgroundColor.value,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          onTap: () => _showColorPicker(
            context,
            'ambadika',
            colorController.backgroundColor.value,
            (color) => colorController.updateColors(background: color),
          ),
        )),
        Obx(() => ListTile(
          title: const Text('Lokon\'ny menu'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorController.drawerColor.value,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          onTap: () => _showColorPicker(
            context,
            'menu',
            colorController.drawerColor.value,
            (color) => colorController.updateColors(drawer: color),
          ),
        )),
        Obx(() => ListTile(
          title: const Text('Lokon\'ny kisary'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colorController.iconColor.value,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
          onTap: () => _showColorPicker(
            context,
            'kisary',
            colorController.iconColor.value,
            (color) => colorController.updateColors(icon: color),
          ),
        )),
      ],
    );
  }
}
