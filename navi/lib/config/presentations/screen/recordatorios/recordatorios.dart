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
                    label: recordatorio['nombre'] ?? 'Sin nombre',
                    cantidad: recordatorio['cantidad'] ?? 0,
                    duracion: recordatorio['duracion'] ?? 0,
                    duracionUnidad: recordatorio['duracion_unidad'] ?? 'N/A',
                    ciclo: recordatorio['ciclo'] ?? 0,
                    fechaCreacion: recordatorio['fecha_creacion'] ?? 'N/A',
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
  final String label;
  final int cantidad;
  final int duracion;
  final String duracionUnidad;
  final int ciclo;
  final String fechaCreacion;

  const _RecordatorioCard({
    required this.label,
    required this.cantidad,
    required this.duracion,
    required this.duracionUnidad,
    required this.ciclo,
    required this.fechaCreacion,
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
            const SizedBox(height: 10),
            Text(
              'Cantidad: $cantidad',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Duración: $duracion $duracionUnidad',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Ciclo: $ciclo',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Fecha de Creación: $fechaCreacion',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10), // Espacio entre la información y los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Acción para borrar el recordatorio
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
