#include <WiFi.h>
#include <PubSubClient.h>
#include <PulseSensorPlayground.h>

// Configuración de WiFi
const char* ssid = "Ubee28C4-2.4G";
const char* password = "96E6F328C4";

// Configuración del broker MQTT
const char* mqtt_server = "broker.emqx.io";
const int mqtt_port = 1883;
const char* mqtt_topic = "navi/beat";

// Configuración del sensor de pulso
const int PulseWire = 34; 
const int PULSE_BLINK = 13;
const int PULSE_FADE = 5;
const int THRESHOLD = 685;  
PulseSensorPlayground pulseSensor;

// Configuración de WiFi y MQTT
WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  Serial.begin(115200);
  
  // Conexión a WiFi
  setup_wifi();

  analogReadResolution(10);
  
  // Conexión al broker MQTT
  client.setServer(mqtt_server, mqtt_port);

  // Configuración del sensor de pulso
  pulseSensor.analogInput(PulseWire);
  pulseSensor.blinkOnPulse(PULSE_BLINK);
  pulseSensor.fadeOnPulse(PULSE_FADE);
  pulseSensor.setSerial(Serial);
  pulseSensor.begin();
  pulseSensor.setThreshold(THRESHOLD);
}

void loop() {
  // Mantener la conexión al broker MQTT
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // Lectura del pulso
  int myBPM = pulseSensor.getBeatsPerMinute(); 

  // Enviar datos si se detecta un latido
  if (pulseSensor.sawStartOfBeat()) {
    Serial.println("Latido detectado!");
    Serial.print("BPM: ");
    Serial.println(myBPM);
    
    // Publicar la señal en el broker MQTT
    String bpmString = String(myBPM);
    client.publish(mqtt_topic, bpmString.c_str());
  }
}

// Función para conectarse al WiFi
void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Conectando a ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi conectado");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

// Función para reconectar al broker MQTT si la conexión se pierde
void reconnect() {
  while (!client.connected()) {
    Serial.print("Conectando al broker MQTT...");
    if (client.connect("NAVICLIENTAAAA")) {
      Serial.println("conectado");
    } else {
      Serial.print("fallido, rc=");
      Serial.print(client.state());
      Serial.println(" Intentando de nuevo en 5 segundos");
      delay(5000);
    }
  }
}
