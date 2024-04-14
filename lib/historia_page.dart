import 'package:flutter/material.dart';

class HistoriaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historia'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              context,
              'La Defensa Civil',
              'La defensa civil tiene su origen formal en la primera guerra mundial, perfeccionándose luego en la siguiente gran guerra y nace como una estructura destinada a asistir a las víctimas civiles de los conflictos bélicos.',
            ),
            _buildCard(
              context,
              'Sistemas de Protección Civil',
              'Durante la segunda guerra mundial se organizan distintos sistemas de protección civil, de los cuales el más difundido es el de "Defensa Antiaérea Pasiva", destinada a proteger a la población.',
            ),
            _buildCard(
              context,
              'Orígenes Antiguos',
              'Se le atribuye como primer antecedente formal de la defensa civil alrededor del año 1830, durante la guerra civil norteamericana, cuando los vecinos se unen para hacer frente a los ataques de sus enemigos.',
            ),
            _buildCard(
              context,
              'Día Nacional de la Defensa Civil',
              'En nuestro país se estableció el 23 de noviembre para celebrar el “Día Nacional de la Defensa Civil”, mediante el decreto Nº 1988/81 del Poder Ejecutivo Nacional.',
            ),
            _buildCard(
              context,
              'Legislación y Desarrollo',
              'Es en este siglo, después de la segunda guerra mundial, que se establecen las primeras legislaciones completas para enfrentar la planificación de emergencias.',
            ),
            _buildCard(
              context,
              'Voluntariado',
              'La Defensa Civil se nutre principalmente de voluntarios que prestan su tiempo y esfuerzo para ayudar a la comunidad en situaciones de emergencia y desastre.',
            ),
            _buildCard(
              context,
              'Entrenamiento y Capacitación',
              'Los voluntarios de la Defensa Civil reciben entrenamiento y capacitación especializada para poder responder de manera efectiva y segura durante situaciones de crisis.',
            ),
            _buildCard(
              context,
              'Coordinación con Autoridades',
              'La Defensa Civil trabaja en estrecha colaboración con las autoridades locales, estatales y federales para coordinar acciones de preparación, respuesta y recuperación ante desastres.',
            ),
            _buildCard(
              context,
              'Prevención y Educación',
              'La Defensa Civil promueve la prevención y la educación en la comunidad sobre cómo prepararse y responder ante desastres naturales y emergencias.',
            ),
            _buildCard(
              context,
              'Alianzas Internacionales',
              'La Defensa Civil forma parte de redes y alianzas internacionales para compartir conocimientos, recursos y mejores prácticas en gestión de desastres y respuesta humanitaria.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String content) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
