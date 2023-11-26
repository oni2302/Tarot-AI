import 'package:flutter/material.dart';
import 'package:tarot_ai/screen/TarotCardListScreen.dart';
void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TarotCardListScreen(),
    );
  }
}
