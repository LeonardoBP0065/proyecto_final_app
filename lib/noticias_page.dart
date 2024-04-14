import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  late List<dynamic> noticias = [];

  @override
  void initState() {
    super.initState();
    _fetchNoticias();
  }

  Future<void> _fetchNoticias() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/noticias.php'));

    if (response.statusCode == 200) {
      setState(() {
        noticias = jsonDecode(response.body)['datos'];
      });
    } else {
      throw Exception('Error al cargar las noticias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
      ),
      body: noticias.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: noticias.length,
              itemBuilder: (context, index) {
                final noticia = noticias[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noticia['titulo'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Fecha: ${noticia['fecha']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          noticia['contenido'],
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Image.network(
                          noticia['foto'],
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
