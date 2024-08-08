import 'package:flutter/material.dart';

class AnadirRecordatoriosScreen extends StatefulWidget {
  static const String routeName = "anadir_recordatorios_screen";

  @override
  _AnadirRecordatoriosScreenState createState() => _AnadirRecordatoriosScreenState();
}

class _AnadirRecordatoriosScreenState extends State<AnadirRecordatoriosScreen> {
  final TextEditingController _nombreController = TextEditingController();
  int _cantidad = 0;
  int _duracion = 0;
  String _duracionUnidad = 'Días';
  final List<String> _unidades = ['Días', 'Semanas', 'Meses', 'Años'];
  final TextEditingController _cicloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Recordatorios'),
        backgroundColor: Colors.tealAccent[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre: ',
                labelStyle: TextStyle(color: Colors.tealAccent[400]),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent[400]!),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text('Cantidad/Docis: $_cantidad'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _cantidad++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_cantidad > 0) _cantidad--;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Duración',
                      labelStyle: TextStyle(color: Colors.tealAccent[400]),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent[400]!),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _duracion = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: _duracionUnidad,
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
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _cicloController,
              decoration: InputDecoration(
                labelText: 'Ciclo (Horas)',
                labelStyle: TextStyle(color: Colors.tealAccent[400]),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent[400]!),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Acción para guardar para el futuro.
                  },
                  child: Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[400],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción para cancelar para el futuro.
                  },
                  child: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
