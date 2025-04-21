import 'package:flutter/material.dart';

class ContentTabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  
  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);

  const ContentTabButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? polinesYellow : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: polinesBlue,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}