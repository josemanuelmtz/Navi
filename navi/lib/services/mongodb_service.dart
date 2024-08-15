import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  static Db? _db;

  static Future<void> connect() async {
    try {
      _db = await Db.create('mongodb+srv://navi:fkHJGN5THtNdEBH6@navi.4im7n.mongodb.net/Navi?retryWrites=true&w=majority');
      await _db?.open();
      print('Conectado a MongoDB Atlas');
    } catch (e) {
      print('Error al conectar a MongoDB Atlas: $e');
    }
  }

  static Future<void> close() async {
    await _db?.close();
    print('Conexión cerrada');
  }

  static DbCollection getCollection(String collectionName) {
    return _db!.collection(collectionName);
  }
}


/*
import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  static Db? _db;

  static Future<void> connect() async {
    _db = await Db.create('mongodb+srv://navi:<fkHJGN5THtNdEBH6>@navi.4im7n.mongodb.net/?retryWrites=true&w=majority&appName=Navi');
    await _db?.open();
    print('Conectado a MongoDB Atlas');
  }

  static Future<void> close() async {
    await _db?.close();
    print('Conexión cerrada');
  }

  static DbCollection getCollection(String collectionName) {
    return _db!.collection(collectionName);
  }
}
*/