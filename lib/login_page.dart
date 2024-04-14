import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_login_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _message = '';

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://adamix.net/defensa_civil/def/iniciar_sesion.php'),
        body: {
          'cedula': email,
          'clave': password,
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['exito'] != null && responseData['exito'] == true) {
        setState(() {
          _message = 'Inicio de sesión exitoso';
          _isLoading = false;
        });
        print('Respuesta del servidor: $responseData');

        final String? token = responseData['token'];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PostLoginPage(token: token)),
        );
      } else {
        setState(() {
          _message = 'Error al iniciar sesión';
          _isLoading = false;
        });
        print('Error al iniciar sesión: $responseData');
      }
    } catch (error) {
      setState(() {
        _message = 'Error al iniciar sesión: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
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
                    Text(
                      'Inicio de Sesión',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Cédula',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su cédula';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      child: Text('Iniciar Sesión'),
                    ),
                    SizedBox(height: 10),
                    if (_message.isNotEmpty)
                      Text(
                        _message,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginForm(),
  ));
}
