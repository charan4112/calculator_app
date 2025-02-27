import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class CalculatorProvider extends ChangeNotifier {
  String _input = "";
  String _output = "0";
  double _memory = 0.0;
  List<String> _history = [];
  bool _isDarkMode = true;
  bool _isScientificMode = false;

  CalculatorProvider() {
    _loadThemePreference();
  }

  String get input => _input;
  String get output => _output;
  List<String> get history => _history;
  bool get isDarkMode => _isDarkMode;
  bool get isScientificMode => _isScientificMode;

  void addInput(String value) {
    if (value == ".") {
      if (_input.isNotEmpty && _input.contains(".")) return;
    }

    if (value == "=") {
      _calculateResult();
    } else if (value == "sin" || value == "cos" || value == "tan" || 
               value == "log" || value == "ln" || value == "√" || value == "^") {
      _handleScientificOperation(value);
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

      _output = eval.toStringAsFixed(6);
      _history.insert(0, "$_input = $_output");
      if (_history.length > 10) {
        _history.removeLast();
      }
    } catch (e) {
      _output = "Error";
    }
    notifyListeners();
  }

  void _handleScientificOperation(String operation) {
    try {
      double num = double.tryParse(_input) ?? 0.0;

      if (operation == "sin") {
        _output = sin(num * pi / 180).toStringAsFixed(6);
      } else if (operation == "cos") {
        _output = cos(num * pi / 180).toStringAsFixed(6);
      } else if (operation == "tan") {
        _output = tan(num * pi / 180).toStringAsFixed(6);
      } else if (operation == "log") {
        _output = log(num) / log(10).toStringAsFixed(6);
      } else if (operation == "ln") {
        _output = log(num).toStringAsFixed(6);
      } else if (operation == "√") {
        _output = sqrt(num).toStringAsFixed(6);
      } else if (operation == "^") {
        _output += "^";
      }

      _input = _output;
    } catch (e) {
      _output = "Error";
    }
    notifyListeners();
  }

  // Toggle Scientific Mode
  void toggleScientificMode() {
    _isScientificMode = !_isScientificMode;
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

  // Theme Toggle
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemePreference();
    notifyListeners();
  }

  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    notifyListeners();
  }

  void _saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }
}
