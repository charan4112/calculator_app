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
            icon: Icon(
              calculator.isScientificMode ? Icons.calculate : Icons.functions,
              color: Colors.white,
            ),
            onPressed: () => calculator.toggleScientificMode(),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => calculator.clearHistory(),
          ),
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

          // Scientific Mode Toggle Buttons
          if (calculator.isScientificMode)
            Wrap(
              spacing: 10,
              children: [
                ButtonWidget(label: 'sin', color: Colors.purple, onTap: () => calculator.addInput('sin')),
                ButtonWidget(label: 'cos', color: Colors.purple, onTap: () => calculator.addInput('cos')),
                ButtonWidget(label: 'tan', color: Colors.purple, onTap: () => calculator.addInput('tan')),
                ButtonWidget(label: 'log', color: Colors.purple, onTap: () => calculator.addInput('log')),
                ButtonWidget(label: 'ln', color: Colors.purple, onTap: () => calculator.addInput('ln')),
                ButtonWidget(label: '√', color: Colors.purple, onTap: () => calculator.addInput('√')),
                ButtonWidget(label: '^', color: Colors.purple, onTap: () => calculator.addInput('^')),
              ],
            ),
        ],
      ),
    );
  }
}
