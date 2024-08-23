#include <WiFi.h>
#include <PubSubClient.h>
#include <PulseSensorPlayground.h>
#include "DHT.h"
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// Configuración de WiFi
const char* ssid = "iPhoneX";
const char* password = "manuel1501";

// Configuración del broker MQTT
const char* mqtt_server = "broker.emqx.io";
const int mqtt_port = 1883;
const char* mqtt_topic_beat = "navi/beat";
const char* mqtt_topic_temp = "navi/temp";
const char* mqtt_topic_hum = "navi/hum";

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

// Configuración de pantalla OLED
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define OLED_RESET -1
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

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

  // Inicializar pantalla OLED
  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) { 
    Serial.println(F("SSD1306 allocation failed"));
    for (;;);
  }
  
  display.display();
  delay(2000); // Espera 2 segundos
  display.clearDisplay();
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
  }

  if(!isnan(temperatura)){
    String tempString = String(temperatura);
    client.publish(mqtt_topic_temp, tempString.c_str());
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

  // Mostrar valores en la pantalla OLED
  display.clearDisplay();
  
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  
  display.setCursor(0,0);
  display.print("BPM: ");
  display.println(myBPM);
  
  display.setCursor(0, 16);
  display.print("Temp: ");
  display.print(temperatura);
  display.println(" C");

  display.setCursor(0, 32);
  display.print("Hum: ");
  display.print(humedad);
  display.println(" %");
  
  display.display();

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
