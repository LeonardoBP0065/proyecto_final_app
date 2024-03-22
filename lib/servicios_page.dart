import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  List<dynamic> _servicios = [];

  @override
  void initState() {
    super.initState();
    _fetchServicios();
  }

  Future<void> _fetchServicios() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/servicios.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _servicios = jsonData['datos'];
      });
    } else {
      throw Exception('Failed to load servicios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
      ),
      body: _servicios.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _servicios.length,
              itemBuilder: (context, index) {
                final servicio = _servicios[index];
                return _buildServicioCard(servicio['nombre'], servicio['descripcion'], servicio['foto']);
              },
            ),
    );
  }

  Widget _buildServicioCard(String nombre, String descripcion, String fotoUrl) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(fotoUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(descripcion),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
