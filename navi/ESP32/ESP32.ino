#include <WiFi.h>
#include <PubSubClient.h>
#include <PulseSensorPlayground.h>
#include "DHT.h"

// Configuración de WiFi
const char* ssid = "Ubee28C4-2.4G";
const char* password = "96E6F328C4";

// Configuración del broker MQTT
const char* mqtt_server = "broker.emqx.io";
const int mqtt_port = 1883;
const char* mqtt_topic_beat = "navi/beat";
const char* mqtt_topic_temp = "navi/temperature";
const char* mqtt_topic_hum = "navi/humidity";

// Configuración del sensor de pulso
const int PulseWire = 34; 
const int PULSE_BLINK = 13;
const int PULSE_FADE = 5;
const int THRESHOLD = 685;  
PulseSensorPlayground pulseSensor;

#define DHTPIN 4
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

#define BUZZER_PIN 14

// Configuración de WiFi y MQTT
WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  Serial.begin(115200);

  pinMode(BUZZER_PIN, OUTPUT);
  
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

  dht.begin();
}

void loop() {
  // Mantener la conexión al broker MQTT
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // Lectura del pulso
  int myBPM = pulseSensor.getBeatsPerMinute(); 


  float humedad = dht.readHumidity();
  float temperatura = dht.readTemperature();

  if(!isnan(humedad)){
    String humString = String(humedad);
    client.publish(mqtt_topic_hum, humString.c_str());
    Serial.print("Temp: ");
    Serial.println(temperatura);
  }

  if(!isnan(temperatura)){
    String tempString = String(temperatura);
    client.publish(mqtt_topic_temp, tempString.c_str());
    Serial.print("Hum: ");
    Serial.println(humedad);
  }


  // Enviar datos si se detecta un latido
  if (pulseSensor.sawStartOfBeat()) {
    Serial.println("Latido detectado!");
    Serial.print("BPM: ");
    Serial.println(myBPM);

    if(myBPM > 100){
      tone(BUZZER_PIN, 1000);
    }
    else noTone(BUZZER_PIN);
    
    // Publicar la señal en el broker MQTT
    String bpmString = String(myBPM);
    client.publish(mqtt_topic_beat, bpmString.c_str());
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
