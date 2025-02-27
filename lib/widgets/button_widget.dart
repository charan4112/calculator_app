import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ButtonWidget({
    required this.label,
    required this.onTap,
    this.color = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
