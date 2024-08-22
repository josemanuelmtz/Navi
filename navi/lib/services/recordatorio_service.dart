import 'package:mongo_dart/mongo_dart.dart';
import 'mongodb_service.dart';

class RecordatorioService {
  // Método para insertar un recordatorio
  static Future<void> insertarRecordatorio({
    required String nombre,
    required int cantidad,
    required int duracion,
    required String duracionUnidad,
    required int ciclo,
  }) async {
    try {
      var collection = MongoDBService.getCollection('registrorecordatorio');

      var nuevoRecordatorio = {
        'nombre': nombre,
        'cantidad': cantidad,
        'duracion': duracion,
        'duracionUnidad': duracionUnidad,
        'ciclo': ciclo,
        'fechaCreacion': DateTime.now().toUtc(),
      };

      // Asegúrate de que la colección esté lista para la inserción
      if (collection != null) {
        await collection.insertOne(nuevoRecordatorio);
        print('Recordatorio insertado correctamente');
      } else {
        print('Colección no encontrada');
      }
    } catch (e) {
      print('Error al insertar el recordatorio: $e');
    }
  }

  // Nuevo método para obtener todos los recordatorios
  static Future<List<Map<String, dynamic>>> obtenerRecordatorios() async {
    try {
      var collection = MongoDBService.getCollection('registrorecordatorio');
      if (collection != null) {
        var recordatorios = await collection.find().toList();
        return recordatorios;
      } else {
        print('Colección no encontrada');
        return [];
      }
    } catch (e) {
      print('Error al obtener los recordatorios: $e');
      return [];
    }
  }
}
