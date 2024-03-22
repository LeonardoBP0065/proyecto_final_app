import 'package:flutter/material.dart';
import 'historia_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<String> images = [
    'https://i0.wp.com/ensegundos.do/wp-content/uploads/2021/12/6c77068d5ebd8d9047ee3d10335381cc.jpg?resize=1200%2C640&ssl=1',
    'https://actualidadinfo.files.wordpress.com/2011/12/fotos-011.jpg',
    'https://media.todojujuy.com/p/2949403da55c41dd01a93faad45740aa/adjuntos/227/imagenes/000/362/0000362497/defensa-civil.jpg?0000-00-00-00-00-00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              );
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.black,
                  onPressed: () {
                    Scaffold.of(context)?.openDrawer();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white.withOpacity(0.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Protegiendo a la Comunidad',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'La Defensa Civil RD se dedica a proteger vidas y hogares en la República Dominicana. Con protocolos actualizados y respuesta eficiente, trabajamos para mitigar riesgos y mantener la seguridad de la comunidad. Únete a nosotros para construir un futuro más seguro y resiliente para todos.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(
                  'Funcionalidades Principales',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () {
                  // Acción para Inicio
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('Historia'),
                onTap: () {
                  // Navegar a la página de historia
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoriaPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.build),
                title: Text('Servicios'),
                onTap: () {
                  // Acción para Servicios
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.newspaper),
                title: Text('Noticias'),
                onTap: () {
                  // Acción para Noticias
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library),
                title: Text('Videos'),
                onTap: () {
                  // Acción para Videos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.house),
                title: Text('Albergues'),
                onTap: () {
                  // Acción para Albergues
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Mapa de Albergues'),
                onTap: () {
                  // Acción para Mapa de Albergues
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.warning),
                title: Text('Medidas Preventivas'),
                onTap: () {
                  // Acción para Medidas Preventivas
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Miembros'),
                onTap: () {
                  // Acción para Miembros
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.fitness_center),
                title: Text('Quiero ser Voluntario'),
                onTap: () {
                  // Acción para Quiero ser Voluntario
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Acerca de'),
                onTap: () {
                  // Acción para Acerca de
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Iniciar Sesión'),
                onTap: () {
                  // Acción para Iniciar Sesión
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
