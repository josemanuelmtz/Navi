import 'package:flutter/material.dart';
import 'package:navi/config/presentations/screen/recordatorios/recordatorios.dart';
import 'package:navi/config/presentations/screen/medicamentos/anadirRecordatorio.dart';
import 'package:navi/config/presentations/screen/home/home1_screen.dart';
import 'package:navi/config/presentations/screen/heartrate/heartrate_screen.dart';
import 'package:navi/config/presentations/screen/medicamentos/editarRecordatorio.dart';
import 'services/mongodb_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDBService.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home1Screen(),
      routes: {
        Home1Screen.routeName: (context) => const Home1Screen(),
        RecordatoriosScreen.routeName: (context) => const RecordatoriosScreen(),
        AnadirRecordatoriosScreen.routeName: (context) => AnadirRecordatoriosScreen(),
        HeartRateScreen.routeName: (context) => const HeartRateScreen(),
        EditarRecordatorioScreen.routeName: (context) => EditarRecordatorioScreen(nombre: ''),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
