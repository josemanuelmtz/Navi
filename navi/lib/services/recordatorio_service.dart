import 'package:mysql_client/mysql_client.dart';
import 'mysql_conexion.dart';

class RecordatorioService {
  // Método para insertar recordatorios
  static Future<void> insertarRecordatorio({
    required String nombre,
    required int cantidad,
    required int duracion,
    required String duracionUnidad,
    required int ciclo,
  }) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = """
      INSERT INTO recordatorio (nombre, cantidad, duracion, duracion_unidad, ciclo)
      VALUES ('$nombre', $cantidad, $duracion, '$duracionUnidad', $ciclo)
      """;
      await conn.execute(query);
    } catch (e) {
      print("Error al insertar el recordatorio: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }

  // Método para obtener todos los recordatorios
  static Future<List<Map<String, dynamic>>> obtenerRecordatorios() async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    List<Map<String, dynamic>> recordatorios = [];

    try {
      final results = await conn.execute('SELECT * FROM recordatorio');

      for (final row in results.rows) {
        recordatorios.add({
          'id': row.colAt(0),
          'nombre': row.colAt(1),
          'cantidad': int.tryParse(row.colAt(2).toString()) ?? 0,
          'duracion': int.tryParse(row.colAt(3).toString()) ?? 0,
          'duracion_unidad': row.colAt(4),
          'ciclo': int.tryParse(row.colAt(5).toString()) ?? 0,
          'fecha_creacion': row.colAt(6),
        });
      }
    } catch (e) {
      print("Error al obtener los recordatorios: $e");
      throw e;
    } finally {
      await conn.close();
    }

    return recordatorios;
  }

  // Método para eliminar un recordatorio
  static Future<void> eliminarRecordatorio(int id) async {
    final MySQLService mysqlService = MySQLService();
    final conn = await mysqlService.getConnection();

    try {
      String query = 'DELETE FROM recordatorio WHERE id = :id';
      await conn.execute(query, {'id': id});
    } catch (e) {
      print("Error al eliminar el recordatorio: $e");
      throw e;
    } finally {
      await conn.close();
    }
  }
}
