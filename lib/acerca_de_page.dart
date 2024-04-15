import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'lib/assets/icono.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
              'Desarrolladores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildDeveloperCard(
              name: 'Adalberto Banks Mendoza',
              github: 'AdalBMdev',
              email: '20220791@itla.edu.do',
              image: 'adal.png',
            ),
            SizedBox(height: 20),
            Image.asset(
              'lib/assets/adal.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            _buildDeveloperCard(
              name: 'Leonardo Felipe Pérez Batista',
              github: 'LeonardoBP0065',
              email: '20220910@itla.edu.do',
              image: 'leo.png',
            ),
            SizedBox(height: 20),
            Image.asset(
              'lib/assets/leo.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard({
    required String name,
    required String github,
    required String email,
    required String image,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'GitHub: $github',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '@: $email',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
