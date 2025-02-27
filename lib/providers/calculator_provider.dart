import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String _input = "";
  String _output = "0";

  String get input => _input;
  String get output => _output;

  void addInput(String value) {
    _input += value;
    notifyListeners();
  }

  void clearInput() {
    _input = "";
    _output = "0";
    notifyListeners();
  }
}
