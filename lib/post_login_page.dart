import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostLoginPage extends StatefulWidget {
  final String? token;

  PostLoginPage({Key? key, this.token}) : super(key: key);

  @override
  _PostLoginPageState createState() => _PostLoginPageState();
}

class _PostLoginPageState extends State<PostLoginPage> {
  List<Situacion> situaciones = [];

  late TextEditingController tituloController;
  late TextEditingController descripcionController;
  late TextEditingController latitudController;
  late TextEditingController longitudController;
  late TextEditingController fotoController;

  @override
  void initState() {
    super.initState();
    _fetchSituaciones();

    // Inicializar los controladores de texto
    tituloController = TextEditingController();
    descripcionController = TextEditingController();
    latitudController = TextEditingController();
    longitudController = TextEditingController();
    fotoController = TextEditingController();
  }

  @override
  void dispose() {
    // Limpiar los controladores de texto al salir de la página
    tituloController.dispose();
    descripcionController.dispose();
    latitudController.dispose();
    longitudController.dispose();
    fotoController.dispose();
    super.dispose();
  }

Future<void> _fetchSituaciones() async {
  try {
    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php'),
      body: {'token': widget.token ?? ''},
    );

    final responseData = json.decode(response.body);

    if (responseData['exito'] != null && responseData['exito'] == true) {
      final List<dynamic> situacionesData = responseData['datos'];
      setState(() {
        situaciones = situacionesData.map((data) => Situacion.fromJson(data)).toList();
      });
      print('Situaciones cargadas exitosamente');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(responseData['mensaje'] ?? 'Error al cargar situaciones'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Error al cargar situaciones: $error'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}


  Future<void> _fetchNoticiasEspecificas() async {
    try {
      final response = await http.post(
        Uri.parse('https://adamix.net/defensa_civil/def/noticias_especificas.php'),
        body: {'token': widget.token ?? ''},
      );

      final responseData = json.decode(response.body);

      // Aquí debes implementar la lógica para manejar la respuesta de las noticias específicas
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Error al cargar noticias específicas: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _reportarSituacion(String titulo, String descripcion, double latitud, double longitud, String foto) async {
  try {
    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/nueva_situacion.php'),
      body: {
        'token': widget.token ?? '',
        'titulo': titulo,
        'descripcion': descripcion,
        'latitud': latitud.toString(),
        'longitud': longitud.toString(),
        'foto': foto,
      },
    );

    final responseData = json.decode(response.body);

    if (responseData['exito'] != null && responseData['exito'] == true) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Éxito'),
          content: Text(responseData['mensaje'] ?? 'Situación reportada exitosamente'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Actualizar la lista de situaciones después de agregar una nueva
                _fetchSituaciones();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      print('Situación reportada exitosamente');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(responseData['mensaje'] ?? 'Error al reportar situación'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Error al reportar situación: $error'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Login'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              _fetchNoticiasEspecificas();
            },
            child: Text('Ver Noticias Específicas'),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Reportar Situación'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: tituloController,
                          decoration: InputDecoration(labelText: 'Título'),
                        ),
                        TextField(
                          controller: descripcionController,
                          decoration: InputDecoration(labelText: 'Descripción'),
                          maxLines: null,
                        ),
                        TextField(
                          controller: latitudController,
                          decoration: InputDecoration(labelText: 'Latitud'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: longitudController,
                          decoration: InputDecoration(labelText: 'Longitud'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: fotoController,
                          decoration: InputDecoration(labelText: 'Foto'),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _reportarSituacion(
                          tituloController.text,
                          descripcionController.text,
                          double.parse(latitudController.text),
                          double.parse(longitudController.text),
                          fotoController.text,
                        );

                        // Limpiar los campos de entrada después de reportar la situación
                        tituloController.clear();
                        descripcionController.clear();
                        latitudController.clear();
                        longitudController.clear();
                        fotoController.clear();

                        Navigator.pop(context);
                      },
                      child: Text('Enviar'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Reportar Situación'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistorialSituaciones(situaciones: situaciones),
                ),
              );
            },
            child: Text('Mis Situaciones'),
          ),
        ],
      ),
    );
  }
}

class Situacion {
  final String id;
  final String titulo;
  final String descripcion;
  final double latitud;
  final double longitud;
  final String estado;

  Situacion({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.estado,
  });

  factory Situacion.fromJson(Map<String, dynamic> json) {
    return Situacion(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      latitud: double.parse(json['latitud']),
      longitud: double.parse(json['longitud']),
      estado: json['estado'],
    );
  }
}

class HistorialSituaciones extends StatelessWidget {
  final List<Situacion> situaciones;

  const HistorialSituaciones({Key? key, required this.situaciones}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Situaciones'),
      ),
      body: ListView.builder(
        itemCount: situaciones.length,
        itemBuilder: (context, index) {
          final situacion = situaciones[index];
          return ListTile(
            title: Text(situacion.titulo),
            subtitle: Text(situacion.descripcion),
            onTap: () {
              // Lógica para ver detalles de la situación
              // Aquí debes implementar la lógica para mostrar detalles de la situación seleccionada
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PostLoginPage(),
  ));
}
