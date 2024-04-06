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

  @override
  void initState() {
    super.initState();
    _fetchAlberguesData();
  }

  Future<void> _fetchAlberguesData() async {
    final response = await http.get(Uri.parse("https://adamix.net/defensa_civil/def/albergues.php"));
    if (response.statusCode == 200) {
      final List<dynamic> alberguesData = json.decode(response.body);
      setState(() {
        markers = alberguesData.map((data) {
          return Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(data['latitud'], data['longitud']),
            builder: (context) => Container(
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
          center: LatLng(0, 0),
          zoom: 10.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: markers),
        ],
      ),
    );
  }
}
