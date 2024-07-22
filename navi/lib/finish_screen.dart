import 'package:flutter/material.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terminar'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Acción al presionar el botón de terminar
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(40),
          ),
          child: const Text(
            'Terminar',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
