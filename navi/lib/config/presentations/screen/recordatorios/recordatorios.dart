import 'package:flutter/material.dart';
import 'package:navi/services/recordatorio_service.dart';

class RecordatoriosScreen extends StatefulWidget {
  static const String routeName = "recordatorios_screen";

  const RecordatoriosScreen({super.key});

  @override
  _RecordatoriosScreenState createState() => _RecordatoriosScreenState();
}

class _RecordatoriosScreenState extends State<RecordatoriosScreen> {
  Future<List<Map<String, dynamic>>>? _futureRecordatorios;

  @override
  void initState() {
    super.initState();
    _loadRecordatorios();
  }

  void _loadRecordatorios() {
    setState(() {
      _futureRecordatorios = RecordatorioService.obtenerRecordatorios();
    });
  }

  Future<void> _confirmarEliminacion(int id) async {
    bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar este recordatorio?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cerrar el cuadro de diálogo sin eliminar
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar la eliminación
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      _eliminarRecordatorio(id);
    }
  }

  void _eliminarRecordatorio(int id) async {
    try {
      await RecordatorioService.eliminarRecordatorio(id);
      _loadRecordatorios();
    } catch (e) {
      // Manejo de errores al eliminar el recordatorio
      print("Error al eliminar el recordatorio: $e");
    }
  }

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
          future: _futureRecordatorios,
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
                    id: int.parse(recordatorio['id']),
                    label: recordatorio['nombre'] ?? 'Sin nombre',
                    cantidad: recordatorio['cantidad'] ?? 0,
                    duracion: recordatorio['duracion'] ?? 0,
                    duracionUnidad: recordatorio['duracion_unidad'] ?? 'N/A',
                    ciclo: recordatorio['ciclo'] ?? 0,
                    fechaCreacion: recordatorio['fecha_creacion'] ?? 'N/A',
                    onDelete: _confirmarEliminacion,
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
  final int id;
  final String label;
  final int cantidad;
  final int duracion;
  final String duracionUnidad;
  final int ciclo;
  final String fechaCreacion;
  final Function(int) onDelete;

  const _RecordatorioCard({
    required this.id,
    required this.label,
    required this.cantidad,
    required this.duracion,
    required this.duracionUnidad,
    required this.ciclo,
    required this.fechaCreacion,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    onDelete(id);
                  },
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Borrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 33),
                    foregroundColor: Colors.white,
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