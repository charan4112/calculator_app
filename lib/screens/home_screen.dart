import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          // Display area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    calculator.input,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    calculator.output,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Calculator buttons
          Container(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                ButtonWidget(label: 'C', color: Colors.red, onTap: () => calculator.clearInput()),
                ButtonWidget(label: '⌫', onTap: () {
                  if (calculator.input.isNotEmpty) {
                    calculator.addInput(calculator.input.substring(0, calculator.input.length - 1));
                  }
                }),
                ButtonWidget(label: '%', onTap: () => calculator.addInput('%')),
                ButtonWidget(label: '/', color: Colors.orange, onTap: () => calculator.addInput('/')),
                
                ButtonWidget(label: '7', onTap: () => calculator.addInput('7')),
                ButtonWidget(label: '8', onTap: () => calculator.addInput('8')),
                ButtonWidget(label: '9', onTap: () => calculator.addInput('9')),
                ButtonWidget(label: '*', color: Colors.orange, onTap: () => calculator.addInput('*')),

                ButtonWidget(label: '4', onTap: () => calculator.addInput('4')),
                ButtonWidget(label: '5', onTap: () => calculator.addInput('5')),
                ButtonWidget(label: '6', onTap: () => calculator.addInput('6')),
                ButtonWidget(label: '-', color: Colors.orange, onTap: () => calculator.addInput('-')),

                ButtonWidget(label: '1', onTap: () => calculator.addInput('1')),
                ButtonWidget(label: '2', onTap: () => calculator.addInput('2')),
                ButtonWidget(label: '3', onTap: () => calculator.addInput('3')),
                ButtonWidget(label: '+', color: Colors.orange, onTap: () => calculator.addInput('+')),

                ButtonWidget(label: '0', onTap: () => calculator.addInput('0')),
                ButtonWidget(label: '.', onTap: () => calculator.addInput('.')),
                ButtonWidget(label: '=', color: Colors.green, onTap: () {
                  // Logic will be added in Step 4
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
