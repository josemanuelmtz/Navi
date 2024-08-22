import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navi/source/network/mqtt_service.dart';

class HeartRateScreen extends StatefulWidget {
  static const String routeName = "heart_rate_screen";

  const HeartRateScreen({super.key});

  @override
  _HeartRateScreenState createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen>
    with SingleTickerProviderStateMixin {
  double heartRate = 75.0; // Ritmo cardíaco simulado
  double temperature = 36.5; // Temperatura simulada
  double humidity = 50.0; // Humedad simulada

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _temperatureAnimation;
  late Animation<double> _humidityAnimation;

  late StreamSubscription<double> _heartRateSubscription;
  late StreamSubscription<double> _temperatureSubscription;
  late StreamSubscription<double> _humiditySubscription;

  @override
  void initState() {
    super.initState();

    // Configuración del controlador de animación
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    // Configuración de la animación para el ritmo cardíaco
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Configuración de la animación para la temperatura
    _temperatureAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Configuración de la animación para la humedad
    _humidityAnimation = Tween<double>(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _heartRateSubscription = MqttService.obtenerPulsosStream().listen((event) {
      setState(() {
        heartRate = event;
      });
    });

    _temperatureSubscription = MqttService.obtenerTemperaturaStream().listen((event) {
      setState(() {
        temperature = event;
      });
    });

    _humiditySubscription = MqttService.obtenerHumedadStream().listen((event) {
      setState(() {
        humidity = event;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Disponer del controlador cuando no se use más
    super.dispose();

    print('::: Cerrando suscripciones :::');
    _heartRateSubscription.cancel();
    _temperatureSubscription.cancel();
    _humiditySubscription.cancel();
  }

  Color _getTemperatureColor(double temperature) {
    return temperature > 30 ? const Color.fromARGB(255, 208, 187, 3) : Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ritmo Cardiaco, Temperatura y Humedad'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Corazón grande con efecto de latido
            ScaleTransition(
              scale: _animation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      '$heartRate BPM',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ritmo Cardíaco',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            // Sensor de temperatura con color variable y efecto sutil
            AnimatedBuilder(
              animation: _temperatureAnimation,
              builder: (context, child) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getTemperatureColor(temperature),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: Offset(0, _temperatureAnimation.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.thermostat,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          '$temperature °C',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Temperatura',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            // Sensor de humedad con efecto de llenado
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.water_drop,
                        size: 40,
                        color: Colors.white,
                      ),
                      Text(
                        '$humidity %',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Contenedor para el efecto de llenado
                AnimatedBuilder(
                  animation: _humidityAnimation,
                  builder: (context, child) {
                    return Positioned(
                      bottom: 0,
                      child: Container(
                        width: 120,
                        height: (120 * (_humidityAnimation.value / 100)),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Humedad',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: const Text('Regresar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
