import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorProvider extends ChangeNotifier {
  String _input = "";
  String _output = "0";
  double _memory = 0.0;
  List<String> _history = [];
  bool _isDarkMode = true;

  CalculatorProvider() {
    _loadThemePreference();
  }

  String get input => _input;
  String get output => _output;
  List<String> get history => _history;
  bool get isDarkMode => _isDarkMode;

  void addInput(String value) {
    if (value == ".") {
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

  // Load theme preference from storage
  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    notifyListeners();
  }

  // Save theme preference
  void _saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }
}
