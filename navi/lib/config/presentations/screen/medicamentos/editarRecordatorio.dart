import 'package:flutter/material.dart';

class EditarRecordatorioScreen extends StatefulWidget {
  static const String routeName = "editar_recordatorio_screen";

  final String nombre;

  const EditarRecordatorioScreen({super.key, required this.nombre});

  @override
  _EditarRecordatorioScreenState createState() =>
      _EditarRecordatorioScreenState();
}

class _EditarRecordatorioScreenState extends State<EditarRecordatorioScreen> {
  late TextEditingController _nombreController;
  int _cantidad = 0;
  int _duracion = 0;
  String _duracionUnidad = 'Días';
  final List<String> _unidades = ['Días', 'Semanas', 'Meses', 'Años'];
  final TextEditingController _cicloController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Recordatorio'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Icon(
                Icons.event_note,
                size: 40,
                color: Color(0xFF00796B),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nombreController,
              maxLength: 30,
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: const TextStyle(color: Color(0xFF00796B)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF00796B)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  'Cantidad/Dosis: $_cantidad',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_cantidad > 0) _cantidad--;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (_cantidad < 50) _cantidad++;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      labelText: 'Duración',
                      labelStyle: const TextStyle(color: Color(0xFF00796B)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF00796B)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      counterText: '',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _duracion = int.tryParse(value) ?? 0;
                        if (_duracion > 99) _duracion = 99;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF00796B), width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButton<String>(
                      value: _duracionUnidad,
                      isExpanded: true,
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _duracionUnidad = newValue!;
                        });
                      },
                      items: _unidades.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cicloController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ciclo (Horas)',
                labelStyle: const TextStyle(color: Color(0xFF00796B)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF00796B)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  int ciclo = int.tryParse(value) ?? 0;
                  if (ciclo < 1) ciclo = 1;
                  if (ciclo > 24) ciclo = 24;
                  _cicloController.text = ciclo.toString();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Acción para guardar cambios
                  },
                  child: const Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresar sin guardar cambios
                  },
                  child: const Text('Cancelar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Regresar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
