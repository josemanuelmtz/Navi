import 'package:flutter/material.dart';
import 'package:navi/config/presentations/screen/medicamentos/editarRecordatorio.dart';

const recordatorios = <Map<String, dynamic>>[
  {'label': 'Recordatorio 1'},
  {'label': 'Recordatorio 2'},
  {'label': 'Recordatorio 3'},
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
            const Expanded(
              child: _RecordatoriosView(),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Padding del botón
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
        children: recordatorios
            .map((recordatorio) => _RecordatorioCard(
                  label: recordatorio['label'],
                ))
            .toList(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // Espacio entre el texto y los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditarRecordatorioScreen(nombre: label),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Color del botón Editar
                    foregroundColor: Colors.white, // Color del texto
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Acción para borrar el recordatorio
                  },
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Borrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 33), // Color del botón Borrar
                    foregroundColor: Colors.white, // Color del texto
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
