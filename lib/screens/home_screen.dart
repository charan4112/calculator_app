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
            alignment: Alignment.bottomRight,
            child: Text(
              calculator.input,
              style: TextStyle(fontSize: 30, color: calculator.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
