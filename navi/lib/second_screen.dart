import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Pantalla'),
      ),
      body: const Center(
        child: Text(
          'Esta es la segunda pantalla',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
