import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/calculator_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
      child: Consumer<CalculatorProvider>(
        builder: (context, calculator, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Calculator App',
            theme: calculator.isDarkMode
                ? ThemeData.dark().copyWith(
                    textTheme: GoogleFonts.robotoTextTheme(),
                  )
                : ThemeData.light().copyWith(
                    textTheme: GoogleFonts.robotoTextTheme(),
                  ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
