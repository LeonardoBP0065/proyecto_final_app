import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlberguesMapPage extends StatefulWidget {
  @override
  _AlberguesMapPageState createState() => _AlberguesMapPageState();
}

class _AlberguesMapPageState extends State<AlberguesMapPage> {
  List<Marker> markers = [];
  double lat = 0;
  double lng = 0;

  @override
  void initState() {
    super.initState();
    _fetchAlberguesData();
  }

Future<void> _fetchAlberguesData() async {
  final response = await http.get(Uri.parse("https://adamix.net/defensa_civil/def/albergues.php"));

  if (response.statusCode == 200) {
    final Map<String, dynamic> alberguesData = json.decode(response.body);
    print("Datos de la API: $alberguesData"); // Imprimir los datos de la API
    final List<dynamic> albergues = alberguesData['datos'];
    setState(() {
      markers = albergues.map((albergue) {
        double lat = double.parse(albergue['lat']);
        double lng = double.parse(albergue['lng']);
        this.lat = lat; // Actualiza la variable global de latitud
        this.lng = lng; // Actualiza la variable global de longitud
        return Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(lat, lng),
          child: Container(
            child: Icon(
              Icons.location_pin,
              size: 50.0,
              color: Colors.red,
            ),
          ),
        );
      }).toList();
    });
  } else {
    throw Exception('Failed to load albergues data');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Albergues'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(18.4861, -69.9312), // Centro inicial del mapa en Santo Domingo
          zoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
         MarkerLayer(
          markers: markers.isNotEmpty
              ? markers
              : [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(lat, lng), // Utilizar las coordenadas globales
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on),
                        Text('Latitude: ${lat}'),
                        Text('Longitude: ${lng}'),
                      ],
                    ),
                  ),
                ],
        ),

        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AlberguesMapPage(),
  ));
}
