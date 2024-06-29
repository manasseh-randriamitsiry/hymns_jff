import 'package:flutter/material.dart';
import 'package:permah_flutter/src/learn/utils/drawer.dart';
import 'package:permah_flutter/src/learn/widgets/custom_button_widget.dart';
import 'package:permah_flutter/src/learn/widgets/input_widget.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController textEditingController = TextEditingController();
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth >= 1200;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 40),
              ),
              const SizedBox(height: 10),
              InputWidget(
                controller: textEditingController,
                text: 'Please enter a number',
                color: Colors.blue,
                icon: Icons.monetization_on,
                width: isDesktop ? screenWidth / 2 : (3 * screenWidth / 4),
                height: isDesktop ? 70 : 50,
                keyboardType: TextInputType.number,  // Clavier numérique
              ),
              const SizedBox(height: 5),  // Espacement
              CustomButton(
                text: 'Submit',
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  setState(() {
                    try {
                      double input = double.parse(textEditingController.text);
                      result = input * 4500;
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid input: ${textEditingController.text}')),
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
      drawer: const DrawerScreen(),
    );
  }
}
