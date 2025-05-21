import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  final String imagePath;
  final bool isFlipped;
  final VoidCallback onTap;

  const MemoryCard({
    super.key,
    required this.imagePath,
    required this.isFlipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 80,
        height: 120,
        decoration: BoxDecoration(
          color: isFlipped ? Colors.white : Colors.blue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2), // Proper RGBA format
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child:
            isFlipped
                ? Image.asset(imagePath)
                : Center(
                  child: Text(
                    "?",
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
      ),
    );
  }
}
