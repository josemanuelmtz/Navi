import 'package:flutter/material.dart';

class Home1Screen extends StatelessWidget {
  static const String name = "home1_screen";
  const Home1Screen({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navy'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200, // Ancho del botón
              height: 60, // Alto del botón
              child: ElevatedButton(
                onPressed: () {
                  // Acción para "Ver Recordatorios"
                },
                child: const Text(
                  'Ver Recordatorios',
                  style: TextStyle(fontSize: 18), // Tamaño del texto
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio entre los botones
            SizedBox(
              width: 200, // Ancho del botón
              height: 60, // Alto del botón
              child: ElevatedButton(
                onPressed: () {
                  // Acción para "Añadir Recordatorios"
                },
                child: const Text(
                  'Añadir Recordatorios',
                  style: TextStyle(fontSize: 18), // Tamaño del texto
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

