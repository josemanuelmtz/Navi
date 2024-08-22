import 'package:flutter/material.dart';
import 'package:navi/services/recordatorio_service.dart';

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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: RecordatorioService.obtenerRecordatorios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar los recordatorios'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay recordatorios'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var recordatorio = snapshot.data![index];
                  return _RecordatorioCard(
                    id: recordatorio['id'] as int,
                    label: recordatorio['nombre'] ?? 'Sin nombre',
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class _RecordatorioCard extends StatelessWidget {
  final int id; // Añadido para manejar el id del recordatorio
  final String label;

  const _RecordatorioCard({
    required this.id, // Añadido para recibir el id
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
                    // Acción para editar (no implementada en este código)
                  },
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Color del botón Editar
                    foregroundColor: Colors.white, // Color del texto
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    // Acción para borrar el recordatorio
                    try {
                      await RecordatorioService.eliminarRecordatorio(id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Recordatorio eliminado')),
                      );
                      // Puedes actualizar la UI si es necesario
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al eliminar el recordatorio')),
                      );
                    }
                  },
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Borrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 33), // Color del botón Borrar
                    foregroundColor: Colors.white, // Color del texto
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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