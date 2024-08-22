import 'package:flutter/material.dart';
import 'package:navi/config/presentations/screen/recordatorios/recordatorios.dart';
import 'package:navi/config/presentations/screen/medicamentos/añadirRecordatorio.dart';
import 'package:navi/config/presentations/screen/heartrate/heartrate_screen.dart';

class Home1Screen extends StatelessWidget {
  static const String routeName = "home1_screen";
  const Home1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navy Health'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.local_hospital,
                size: 100,
                color: Colors.teal,
              ),
              const SizedBox(height: 20),
              const Text(
                'Bienvenido a Navy Health',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              HomeButton(
                label: 'Ver Recordatorios',
                icon: Icons.calendar_today,
                onPressed: () {
                  Navigator.pushNamed(context, RecordatoriosScreen.routeName);
                },
              ),
              const SizedBox(height: 20),
              HomeButton(
                label: 'Añadir Recordatorios',
                icon: Icons.add_alert,
                onPressed: () {
                  Navigator.pushNamed(context, AnadirRecordatoriosScreen.routeName);
                },
              ),
              const SizedBox(height: 20),
              HomeButton(
                label: 'Mi Ritmo Cardiaco',
                icon: Icons.favorite,
                onPressed: () {
                  Navigator.pushNamed(context, HeartRateScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const HomeButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
