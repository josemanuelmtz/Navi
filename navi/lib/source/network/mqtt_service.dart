import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final MqttServerClient client;

  MqttService(String server) : client = MqttServerClient(server, '')
  {
     // Agregar la versión minima del protocolo MQTT
    client.setProtocolV311();

    // Tiempo de espera para la conexión
     client.keepAlivePeriod = 20;

     // Generar un mensaje de conexión
      final connMessage = MqttConnectMessage()
      .withClientIdentifier('xyz321')
      .startClean()
      .withWillQos(MqttQos.exactlyOnce);


      client.connectionMessage = connMessage;

      // Agregar un listener para la conexión
      client.onConnected = () {
        print('::: MQTT Client Connected :::');
      };

      // Agregar un listener para la desconexión
      client.onDisconnected = () {
        print('::: MQTT Client Disconnected :::');
      };

      // Agregar un listener para la suscripción
      client.onSubscribed = (String topic) {
        print('::: MQTT Client Subscribed Topic: $topic :::');
      };


    }

  Stream<double> obtenerTemperaturaStream() async* {
    try{
      await client.connect();
    }
    catch(e){
      print(e);
      client.disconnect();
    }

    // Verificar si el cliente se conecto correctamente
    if(client.connectionStatus?.state == MqttConnectionState.connected){
      // Generar la suscripción al topico
      client.subscribe('navio/pulsos', MqttQos.exactlyOnce);


      await for (final c in client.updates!) {
        final pubMessage = c[0].payload as MqttPublishMessage;
        final String message = MqttPublishPayload.bytesToStringAsString(pubMessage.payload.message);

        yield double.tryParse(message) ?? 0;
      }
    }
  }
}