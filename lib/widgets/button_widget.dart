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
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 24, color: color),
        ),
      ),
    );
  }
}
