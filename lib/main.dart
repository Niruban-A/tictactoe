import 'package:flutter/material.dart';
import 'package:tictactoe/home.dart';

void main() {
  runApp(const Tictactoe());
}

class Tictactoe extends StatelessWidget {
  const Tictactoe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic Tac Toe",
      home: Homepage(),
      theme: ThemeData.dark(),
    );
  }
}
