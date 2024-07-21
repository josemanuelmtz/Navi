import 'package:flutter/material.dart';

class RecordatoriosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
        backgroundColor: Colors.teal, // Color de fondo similar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card( // Contenedor para los recordatorios
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 1; i <= 5; i++) 
                      Text('• Recordatorio $i'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio entre la tarjeta y los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {}, 
                  child: Text('Editar'),
                ),
                ElevatedButton(
                  onPressed: () {}, 
                  child: Text('Eliminar'),
                  style: ElevatedButton.styleFrom(
                    iconColor: Colors.red, // Color rojo para el botón Eliminar
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
