import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedidaPreventiva {
  final String id;
  final String titulo;
  final String descripcion;
  final String foto;

  MedidaPreventiva({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.foto,
  });

  factory MedidaPreventiva.fromJson(Map<String, dynamic> json) {
    return MedidaPreventiva(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      foto: json['foto'],
    );
  }
}

class MedidasPreventivasPage extends StatefulWidget {
  const MedidasPreventivasPage({Key? key}) : super(key: key);

  @override
  _MedidasPreventivasPageState createState() => _MedidasPreventivasPageState();
}

class _MedidasPreventivasPageState extends State<MedidasPreventivasPage> {
  late List<MedidaPreventiva> _medidasPreventivas = []; // Inicializa como una lista vacía

  @override
  void initState() {
    super.initState();
    fetchMedidasPreventivas();
  }

  Future<void> fetchMedidasPreventivas() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/medidas_preventivas.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      setState(() {
        _medidasPreventivas = List<MedidaPreventiva>.from(parsed['datos'].map((x) => MedidaPreventiva.fromJson(x)));
      });
    } else {
      throw Exception('Failed to load medidas preventivas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas Preventivas'),
      ),
      body: _medidasPreventivas.isNotEmpty // Verifica si _medidasPreventivas no está vacío antes de construir la lista
          ? ListView.builder(
              itemCount: _medidasPreventivas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medida ${_medidasPreventivas[index].id}: ${_medidasPreventivas[index].titulo}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Image.network(_medidasPreventivas[index].foto),
                        SizedBox(height: 8.0),
                        Text(
                          _medidasPreventivas[index].descripcion,
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
    home: MedidasPreventivasPage(),
  ));
}
