import 'dart:async';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  static final MqttServerClient _client = MqttServerClient('broker.emqx.io', '');
  static bool _isConnected = false;
  static bool _isConnecting = false;

  static Future<void> initialize() async {
    if (_isConnecting) return;
    _isConnecting = true;
    if (_isConnected) return;
    _client.setProtocolV311();
    _client.keepAlivePeriod = 20;
    _client.secure = false;
    _client.useWebSocket = false;
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('navixyz123111')
        .startClean();
    _client.connectionMessage = connMessage;
    _client.onConnected = () {
      print('::: MQTT Client Connected :::');
      _isConnected = true;
    };
    _client.onDisconnected = () {
      print('::: MQTT Client Disconnected :::');
      _isConnected = false;
    };
    _client.onSubscribed = (String topic) {
      print('::: MQTT Client Subscribed Topic: $topic :::');
    };

    // Conectar al servidor
    try {
      await _client.connect();
    } catch (e) {
      print('::: Error al conectar al servidor MQTT: $e :::');
    }
    _isConnecting = false;
  }

  static Stream<double> obtenerPulsosStream() async* {
    await initialize();
    if (!_isConnected) return;

    _client.subscribe('navi/beat', MqttQos.atLeastOnce);
    final StreamController<double> controller = StreamController<double>();

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(payload);
      controller.add(double.parse(payload));
    });

    yield* controller.stream;
  }

  static Stream<double> obtenerTemperaturaStream() async* {
    await initialize();
    if (!_isConnected) return;

    _client.subscribe('navi/temp', MqttQos.atLeastOnce);  
    final StreamController<double> controller = StreamController<double>();

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      controller.add(double.parse(payload));
    });

    yield* controller.stream;
  }

  static Stream<double> obtenerHumedadStream() async* {
    await initialize();
    if (!_isConnected) return;

    _client.subscribe('navi/hum', MqttQos.atLeastOnce);
    final StreamController<double> controller = StreamController<double>();

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      controller.add(double.parse(payload));
    });

    yield* controller.stream;
  }
}
