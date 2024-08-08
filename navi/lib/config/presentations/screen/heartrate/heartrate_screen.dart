import 'package:flutter/material.dart';
import 'package:navi/source/network/mqtt_service.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  _HeartRateScreenState createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  double heartRate = 75.0; // Ritmo cardíaco simulado

  late MqttService _service;

  @override
  void initState() {
    super.initState();
    
    _service = MqttService('broker.emqx.io');

    _service.obtenerTemperaturaStream().listen((event) {
      setState(() {
        // Actualizar el ritmo cardíaco
        heartRate = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ritmo Cardiaco'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Corazón grande
            Container(
              width: 150,
              height: 150,
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
              child: Text(
                '$heartRate BPM',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Ritmo Cardíaco',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}