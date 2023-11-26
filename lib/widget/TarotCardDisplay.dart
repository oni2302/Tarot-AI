import 'package:flutter/material.dart';

class TarotCardFront extends StatelessWidget {
  final String name;

  const TarotCardFront({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue, // Change color or add an image for the card front
      ),
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TarotCardBack extends StatelessWidget {
  const TarotCardBack();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red, // Change color or add an image for the card back
      ),
    );
  }
}
