## Clase `MqttService`
> lib/source/network/mqtt_service.dart

Esta clase cumple la función importante de recibir los datos para desplegarlos en la interfaz del usuario mediante streams.


### Atributos Estáticos

```
    static final MqttServerClient _client = MqttServerClient('broker.emqx.io', '');
    static bool _isConnected = false;
    static bool _isConnecting = false; 
  ```

- **`_client`**: Instancia de `MqttServerClient` para gestionar la conexión MQTT. Se inicializa con el broker `'broker.emqx.io'` y un identificador de cliente vacío.
- **`_isConnected`**: Indica si el cliente está actualmente conectado al servidor MQTT.
- **`_isConnecting`**: Indica si el cliente está en proceso de conexión.

### Métodos Estáticos

#### `Future<void> initialize()`

Inicializa la conexión al servidor MQTT:

1. Verifica si el cliente ya está en proceso de conexión o ya está conectado para evitar conexiones redundantes.
```
    if (_isConnecting) return;
    _isConnecting = true;
    if (_isConnected) return;
```
2. Configura el cliente MQTT con el protocolo `V3.1.1`, un período de mantenimiento de `20` segundos, y establece el uso de WebSockets y conexiones seguras como `false`.
```
    _client.setProtocolV311();
    _client.keepAlivePeriod = 20;
    _client.secure = false;
    _client.useWebSocket = false;
```
3. Define el mensaje de conexión con un identificador de cliente `'navixyz123111'` y lo marca como `startClean`.
```
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('navixyz123111')
        .startClean();
    _client.connectionMessage = connMessage;
```
4. Define los manejadores de eventos para conexión, desconexión y suscripción:
   - `onConnected`: Se llama cuando el cliente se conecta exitosamente. Suscribe a los temas relevantes y establece `_isConnected` en `true`.
   ```
    _client.onConnected = () {
      print('::: MQTT Client Connected :::');
      _suscribirseATopicos();
      _isConnected = true;
    };
    ```
   - `onDisconnected`: Se llama cuando el cliente se desconecta. Establece `_isConnected` en `false`.
   ```
    _client.onDisconnected = () {
      print('::: MQTT Client Disconnected :::');
      _isConnected = false;
    };
   ```
   - `onSubscribed`: Se llama cuando se suscribe a un tema. Imprime el tema suscrito.
    ```
    _client.onSubscribed = (String topic) {
      print('::: MQTT Client Subscribed Topic: $topic :::');
    };
    ```
5. Intenta conectar al servidor MQTT. Si ocurre un error, se imprime un mensaje de error.
```
    // Conectar al servidor
    try {
      await _client.connect();
    } catch (e) {
      print('::: Error al conectar al servidor MQTT: $e :::');
    }
```
6. Finalmente, establece `_isConnecting` en `false`.

#### `void _suscribirseATopicos()`
```
    static void _suscribirseATopicos() {
    _client.subscribe('navi/beat', MqttQos.atLeastOnce);
    _client.subscribe('navi/temperature', MqttQos.atLeastOnce);
    _client.subscribe('navi/humidity', MqttQos.atLeastOnce);
    }
```

Suscribe al cliente a los siguientes temas con calidad de servicio `atLeastOnce`:
- `navi/beat`
- `navi/temperature`
- `navi/humidity`

#### `Stream<double> obtenerPulsosStream()`
```
    static Stream<double> obtenerPulsosStream() async* {
    await initialize();
    final StreamController<double> controller = StreamController<double>();

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttReceivedMessage<MqttMessage> message = event[0];
      if(message.topic == 'navi/beat') {
        final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        controller.add(double.tryParse(payload) ?? 0);
      }
    });

    yield* controller.stream;
  }
```
Devuelve un flujo de datos (`Stream`) que emite pulsos (`beat`) en formato `double`:

1. Llama a `initialize()` para asegurar que la conexión esté establecida.
2. Crea un `StreamController` para gestionar los datos del flujo.
3. Escucha actualizaciones en el cliente MQTT y procesa los mensajes recibidos en el tema `navi/beat`. Convierte el payload del mensaje a un valor `double` y lo añade al `StreamController`.
4. Devuelve el flujo del `StreamController`.

#### `Stream<double> obtenerTemperaturaStream()`
```
  static Stream<double> obtenerTemperaturaStream() async* {
    await initialize();

    final StreamController<double> controller = StreamController<double>();

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttReceivedMessage<MqttMessage> message = event[0];
      if(message.topic == 'navi/temperature') {
        final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        controller.add(double.tryParse(payload) ?? 0);
      }
    });

    yield* controller.stream;
  }
```
Devuelve un flujo de datos (`Stream`) que emite temperaturas en formato `double`:

1. Llama a `initialize()` para asegurar que la conexión esté establecida.
2. Crea un `StreamController` para gestionar los datos del flujo.
3. Escucha actualizaciones en el cliente MQTT y procesa los mensajes recibidos en el tema `navi/temperature`. Convierte el payload del mensaje a un valor `double` y lo añade al `StreamController`.
4. Devuelve el flujo del `StreamController`.

#### `Stream<double> obtenerHumedadStream()`
```
  static Stream<double> obtenerHumedadStream() async* {
    await initialize();

    final StreamController<double> controller = StreamController<double>();

    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttReceivedMessage<MqttMessage> message = event[0];
      if(message.topic == 'navi/humidity') {
        final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        controller.add(double.tryParse(payload) ?? 0);
      }
    });

    yield* controller.stream;
  }
```
Devuelve un flujo de datos (`Stream`) que emite humedad en formato `double`:

1. Llama a `initialize()` para asegurar que la conexión esté establecida.
2. Crea un `StreamController` para gestionar los datos del flujo.
3. Escucha actualizaciones en el cliente MQTT y procesa los mensajes recibidos en el tema `navi/humidity`. Convierte el payload del mensaje a un valor `double` y lo añade al `StreamController`.
4. Devuelve el flujo del `StreamController`.


Este código proporciona una base para interactuar con un broker MQTT y procesar datos en tiempo real a través de flujos en Dart.