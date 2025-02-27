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
      backgroundColor: calculator.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: calculator.isDarkMode ? Colors.grey[900] : Colors.blueGrey[200],
        actions: [
          IconButton(
            icon: Icon(
              calculator.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () => calculator.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => calculator.clearHistory(),
          )
        ],
      ),
      body: Column(
        children: [
          // Display Area
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calculator.input,
                  style: TextStyle(fontSize: 28, color: calculator.isDarkMode ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  calculator.output,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: calculator.isDarkMode ? Colors.white : Colors.black),
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
                    style: TextStyle(color: calculator.isDarkMode ? Colors.white : Colors.black),
                  ),
                );
              },
            ),
          ),

          // Memory Functions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(label: 'MC', color: Colors.blue, onTap: () => calculator.memoryClear()),
              ButtonWidget(label: 'M+', color: Colors.blue, onTap: () => calculator.memoryAdd()),
              ButtonWidget(label: 'M-', color: Colors.blue, onTap: () => calculator.memorySubtract()),
              ButtonWidget(label: 'MR', color: Colors.blue, onTap: () => calculator.memoryRecall()),
            ],
          ),

          // Calculator Buttons
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

                ButtonWidget(label: '=', color: Colors.green, onTap: () => calculator.addInput("=")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
