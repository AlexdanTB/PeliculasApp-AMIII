import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/registro_sceen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 10,
        children: [
          Text('Iniciar Sesión', style: TextStyle(fontSize: 25)),
          Text('Correo Electrónico'),
          TextField(
            decoration: InputDecoration(
              label: Text('Ingresa tu correo electrónico'),
              border: OutlineInputBorder(),
            ),
          ),
          Text('Contraseña'),
          TextField(
            decoration: InputDecoration(
              label: Text('Ingresa tu contraseña'),
              border: OutlineInputBorder(),
            ),
          ),
          FilledButton.icon(
            onPressed: () => {},
            label: Text('Inicia sesión'),
            icon: Icon(Icons.login),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistroScreen()),
            ),
            child: Text('¿No tienes una cuenta? Registrate aquí'),
          ),
        ],
      ),
    );
  }
}
