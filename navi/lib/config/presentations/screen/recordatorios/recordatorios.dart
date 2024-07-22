import 'package:flutter/material.dart';

const recordatorios = <Map<String, dynamic>>[
  {'label': 'Recordatorio 1'},
  {'label': 'Recordatorio 2'},
  {'label': 'Recordatorio 3'},
  {'label': 'Recordatorio 4'},
  {'label': 'Recordatorio 5'},
];

class RecordatoriosScreen extends StatelessWidget {
  static const String name = "recordatorios_screen";

  const RecordatoriosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
        backgroundColor: Colors.teal[800],
      ),
      body: const _RecordatoriosView(),
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
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}
