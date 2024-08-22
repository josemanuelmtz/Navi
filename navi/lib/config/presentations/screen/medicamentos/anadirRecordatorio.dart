import 'package:flutter/material.dart';
import 'package:navi/services/recordatorio_service.dart';

class AnadirRecordatoriosScreen extends StatefulWidget {
  static const String routeName = "anadir_recordatorios_screen";

  @override
  _AnadirRecordatoriosScreenState createState() =>
      _AnadirRecordatoriosScreenState();
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
        title: Row(
          children: const [
            Icon(Icons.book, color: Colors.white), // Icono de libro
            SizedBox(width: 8), // Espacio entre el icono y el texto
            Text('Añadir Recordatorios'),
          ],
        ),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Icono de agenda encima del campo "Nombre"
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
                maxLength: 30, // Limitar a 30 caracteres
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: const TextStyle(color: Color(0xFF00796B)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF00796B)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  counterText: '', // Ocultar el contador de caracteres
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
                        if (_cantidad < 50) _cantidad++; // Limitar a 50
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 2, // Limitar a 2 caracteres
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
                        counterText: '', // Ocultar el contador de caracteres
                      ),
                      onChanged: (value) {
                        setState(() {
                          _duracion = int.tryParse(value) ?? 0;
                          if (_duracion > 99)
                            _duracion = 99; // Limitar a 2 cifras
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: const Color(0xFF00796B), width: 2),
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
                        items: _unidades
                            .map<DropdownMenuItem<String>>((String value) {
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
                    if (ciclo > 24) ciclo = 24; // Limitar entre 1 y 24
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
                      RecordatorioService.insertarRecordatorio(
                        nombre: _nombreController.text,
                        cantidad: _cantidad,
                        duracion: _duracion,
                        duracionUnidad: _duracionUnidad,
                        ciclo: int.tryParse(_cicloController.text) ?? 0,
                      ).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Recordatorio guardado exitosamente')),
                        );
                        Navigator.pop(context); // Regresa a la pantalla anterior
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error al guardar el recordatorio')),
                        );
                      });
                    },
                    child: const Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00796B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Regresar a la pantalla anterior
                    },
                    child: const Text('Cancelar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresar a la pantalla anterior
                  },
                  child: const Text('Regresar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}