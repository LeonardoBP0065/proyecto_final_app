import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Miembro {
  final String id;
  final String foto;
  final String nombre;
  final String cargo;

  Miembro({
    required this.id,
    required this.foto,
    required this.nombre,
    required this.cargo,
  });

  factory Miembro.fromJson(Map<String, dynamic> json) {
    return Miembro(
      id: json['id'],
      foto: json['foto'],
      nombre: json['nombre'],
      cargo: json['cargo'],
    );
  }
}

class MiembrosPage extends StatefulWidget {
  const MiembrosPage({Key? key}) : super(key: key);

  @override
  _MiembrosPageState createState() => _MiembrosPageState();
}

class _MiembrosPageState extends State<MiembrosPage> {
  late List<Miembro> _miembros = []; // Inicializar _miembros como una lista vacía

  @override
  void initState() {
    super.initState();
    fetchMiembros();
  }

  Future<void> fetchMiembros() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/miembros.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      setState(() {
        _miembros = List<Miembro>.from(parsed['datos'].map((x) => Miembro.fromJson(x)));
      });
    } else {
      throw Exception('Failed to load miembros');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miembros de la Defensa Civil'),
      ),
      body: _miembros.isNotEmpty // Verificar si _miembros no está vacío antes de construir el ListView
          ? ListView.builder(
              itemCount: _miembros.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _miembros[index].nombre,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Image.network(_miembros[index].foto),
                        SizedBox(height: 8.0),
                        Text(
                          'Cargo: ${_miembros[index].cargo}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MiembrosPage(),
  ));
}
