import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider extends ChangeNotifier {
  String _input = "";
  String _output = "0";

  String get input => _input;
  String get output => _output;

  void addInput(String value) {
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
    } catch (e) {
      _output = "Error";
    }
    notifyListeners();
  }
}
