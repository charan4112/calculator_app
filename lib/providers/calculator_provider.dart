import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider extends ChangeNotifier {
  String _input = "";
  String _output = "0";
  double _memory = 0.0;
  List<String> _history = [];

  String get input => _input;
  String get output => _output;
  List<String> get history => _history;

  void addInput(String value) {
    if (value == ".") {
      // Prevent multiple decimals in one number
      if (_input.isNotEmpty && _input.contains(".")) return;
    }

    if (value == "=") {
      _calculateResult();
    } else {
      _input += value;
    }
    notifyListeners();
  }

  void clearInput() {
    _input = "";
    _output = "0";
    notifyListeners();
  }

  void _calculateResult() {
    try {
      String expression = _input.replaceAll('×', '*').replaceAll('÷', '/');

      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      _output = eval.toStringAsFixed(6); // Ensure decimal precision

      // Save to history
      _history.insert(0, "$_input = $_output");
      if (_history.length > 10) {
        _history.removeLast(); // Keep only last 10 calculations
      }
    } catch (e) {
      _output = "Error";
    }
    notifyListeners();
  }

  // Memory Functions
  void memoryClear() {
    _memory = 0.0;
    notifyListeners();
  }

  void memoryAdd() {
    _memory += double.tryParse(_output) ?? 0.0;
    notifyListeners();
  }

  void memorySubtract() {
    _memory -= double.tryParse(_output) ?? 0.0;
    notifyListeners();
  }

  void memoryRecall() {
    _output = _memory.toString();
    notifyListeners();
  }

  // Clear History
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
