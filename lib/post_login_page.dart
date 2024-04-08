import 'package:flutter/material.dart';

class PostLoginPage extends StatefulWidget {
  @override
  _PostLoginPageState createState() => _PostLoginPageState();
}

class _PostLoginPageState extends State<PostLoginPage> {
  List<Situacion> situaciones = [];

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
              // Reportar Situación
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
                          decoration: InputDecoration(labelText: 'Título'),
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Descripción'),
                          maxLines: null,
                        ),
                        // Aquí se puede agregar la función para subir una foto en formato base 64
                        SizedBox(height: 10),
                        Text(
                          'Ubicación Geográfica:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Latitud'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Longitud'),
                          keyboardType: TextInputType.number,
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
                        // Guardar la situación reportada
                        final nuevaSituacion = Situacion(
                          titulo: 'Título de ejemplo',
                          descripcion: 'Descripción de ejemplo',
                          latitud: 0.0, // Reemplazar con el valor del campo de texto
                          longitud: 0.0, // Reemplazar con el valor del campo de texto
                        );
                        setState(() {
                          situaciones.add(nuevaSituacion);
                        });
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
              // Mis Situaciones
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistorialSituaciones(situaciones: situaciones),
                ),
              );
            },
            child: Text('Mis Situaciones'),
          ),
          ElevatedButton(
            onPressed: () {
              // Cambiar Contraseña
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cambiar Contraseña'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Contraseña Actual'),
                          obscureText: true,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Nueva Contraseña'),
                          obscureText: true,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Confirmar Nueva Contraseña'),
                          obscureText: true,
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
                        // Lógica para cambiar la contraseña
                        // Esto es solo un ejemplo, no se realiza ninguna operación real aquí
                        print('Contraseña cambiada con éxito');
                        Navigator.pop(context);
                      },
                      child: Text('Cambiar'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Cambiar Contraseña'),
          ),
        ],
      ),
    );
  }
}

class Situacion {
  final String titulo;
  final String descripcion;
  final double latitud;
  final double longitud;

  Situacion({
    required this.titulo,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
  });
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
              // Implementar la funcionalidad para ver detalles de la situación
              print('Detalles de la situación seleccionada');
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
