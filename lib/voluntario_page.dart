import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoluntarioPage extends StatefulWidget {
  @override
  _VoluntarioPageState createState() => _VoluntarioPageState();
}

class _VoluntarioPageState extends State<VoluntarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _claveController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();

  bool _isLoading = false;
  String _message = '';

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://adamix.net/defensa_civil/def/registro.php'),
        body: {
          'cedula': _cedulaController.text,
          'nombre': _nombreController.text,
          'apellido': _apellidoController.text,
          'clave': _claveController.text,
          'correo': _correoController.text,
          'telefono': _telefonoController.text,
        },
      );

      final responseData = json.decode(response.body);
      setState(() {
        _message = responseData['mensaje'];
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _message = 'Error: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alístate con nosotros!'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.group,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _cedulaController,
                decoration: InputDecoration(labelText: 'Cédula'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su cédula';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apellidoController,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _claveController,
                decoration: InputDecoration(labelText: 'Clave'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una clave';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _correoController,
                decoration: InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su teléfono';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
                child: Text('Enviar'),
              ),
              SizedBox(height: 10),
              if (_message.isNotEmpty)
                Text(
                  _message,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
