import 'package:flutter/material.dart';

class ClassicGamePage extends StatefulWidget {
  const ClassicGamePage({super.key});

  @override
  State<ClassicGamePage> createState() => _ClassicGamePageState();
}

class _ClassicGamePageState extends State<ClassicGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classic Game Page'),
      ),
      body: Center(
        child: Text('11x11 Tic Tac Toe Game'),
      ),
    );
  }
}
