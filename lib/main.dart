import 'package:flutter/material.dart';
import 'game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic tac toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
