import 'package:flutter/material.dart';

const recordatorios = <Map<String, dynamic>>[
  {'label': 'Recordatorio 1'},
  {'label': 'Recordatorio 2'},
  {'label': 'Recordatorio 3'},
  {'label': 'Recordatorio 4'},
  {'label': 'Recordatorio 5'},
];

class RecordatoriosScreen extends StatelessWidget {
  static const String routeName = "recordatorios_screen";

  const RecordatoriosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: const _RecordatoriosView(),
            ),
            const SizedBox(height: 20), // Espacio entre la lista y el botón
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: const Text('Regresar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Color de fondo
                foregroundColor: Colors.white, // Color del texto
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding del botón
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordatoriosView extends StatelessWidget {
  const _RecordatoriosView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: recordatorios.map((recordatorio) => _RecordatorioCard(
          label: recordatorio['label'],
        )).toList(),
      ),
    );
  }
}

class _RecordatorioCard extends StatelessWidget {
  final String label;

  const _RecordatorioCard({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8), // Margen entre tarjetas
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'editar':
                      // Acción para editar
                      break;
                    case 'eliminar':
                      // Acción para eliminar
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'editar', 'eliminar'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
