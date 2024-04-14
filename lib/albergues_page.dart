import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Albergue {
  final String ciudad;
  final String codigo;
  final String edificio;
  final String coordinador;
  final String telefono;
  final String capacidad;
  final double lat;
  final double lng;

  Albergue({
    required this.ciudad,
    required this.codigo,
    required this.edificio,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.lat,
    required this.lng,
  });

  factory Albergue.fromJson(Map<String, dynamic> json) {
    return Albergue(
      ciudad: json['ciudad'],
      codigo: json['codigo'],
      edificio: json['edificio'],
      coordinador: json['coordinador'],
      telefono: json['telefono'],
      capacidad: json['capacidad'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
    );
  }
}

class AlberguesPage extends StatefulWidget {
  const AlberguesPage({Key? key}) : super(key: key);

  @override
  _AlberguesPageState createState() => _AlberguesPageState();
}

class _AlberguesPageState extends State<AlberguesPage> {
  late List<Albergue> _albergues;
  late List<Albergue> _filteredAlbergues;
  TextEditingController _searchController = TextEditingController();

  _AlberguesPageState() {
    _albergues = [];
    _filteredAlbergues = [];
    fetchAlbergues();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchAlbergues() async {
    final response =
        await http.get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      setState(() {
        _albergues = List<Albergue>.from(parsed['datos'].map((x) => Albergue.fromJson(x)));
        _filteredAlbergues = _albergues;
      });
    } else {
      throw Exception('Failed to load albergues');
    }
  }

  void _filterAlbergues(String query) {
    setState(() {
      _filteredAlbergues = _albergues.where((albergue) {
        final ciudadLower = albergue.ciudad.toLowerCase();
        final edificioLower = albergue.edificio.toLowerCase();
        final coordinadorLower = albergue.coordinador.toLowerCase();
        return ciudadLower.contains(query.toLowerCase()) ||
            edificioLower.contains(query.toLowerCase()) ||
            coordinadorLower.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showAlbergueDetails(Albergue albergue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(albergue.edificio),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Ciudad: ${albergue.ciudad}'),
                Text('Código: ${albergue.codigo}'),
                Text('Coordinador: ${albergue.coordinador}'),
                Text('Teléfono: ${albergue.telefono}'),
                Text('Capacidad: ${albergue.capacidad}'),
                Text('Latitud: ${albergue.lat}'),
                Text('Longitud: ${albergue.lng}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albergues'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar albergue',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterAlbergues,
            ),
          ),
          Expanded(
            child: _filteredAlbergues != null
                ? ListView.builder(
                    itemCount: _filteredAlbergues.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredAlbergues[index].edificio),
                        subtitle: Text(_filteredAlbergues[index].ciudad),
                        onTap: () {
                          _showAlbergueDetails(_filteredAlbergues[index]);
                        },
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
