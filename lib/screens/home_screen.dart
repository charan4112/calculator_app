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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => calculator.clearHistory(),
          )
        ],
      ),
      body: Column(
        children: [
          // Display Area with Glassmorphism Effect
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calculator.input,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  calculator.output,
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),

          // History Panel
          Expanded(
            child: ListView.builder(
              itemCount: calculator.history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    calculator.history[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),

          // Memory Functions Row (MC, M+, M-, MR)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(label: 'MC', color: Colors.blue, onTap: () => calculator.memoryClear()),
              ButtonWidget(label: 'M+', color: Colors.blue, onTap: () => calculator.memoryAdd()),
              ButtonWidget(label: 'M-', color: Colors.blue, onTap: () => calculator.memorySubtract()),
              ButtonWidget(label: 'MR', color: Colors.blue, onTap: () => calculator.memoryRecall()),
            ],
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
                  calculator.addInput("=");
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
