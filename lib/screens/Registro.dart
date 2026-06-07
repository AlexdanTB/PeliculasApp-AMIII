import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 10,
        children: [
          Text('Registrate', style: TextStyle(fontSize: 25)),
          Text('Nombre de usuario'),
          TextField(
            decoration: InputDecoration(
              label: Text('Escribe tu nick/usuario'),
              border: OutlineInputBorder(),
            ),
          ),
          Text('Correo Electrónico'),
          TextField(
            decoration: InputDecoration(
              label: Text('Ingresa tu correo electrónico'),
              border: OutlineInputBorder(),
            ),
          ),
          Text('Fecha de nacimiento'),
          Text('Contraseña'),
          TextField(
            decoration: InputDecoration(
              label: Text('Ingresa tu contraseña'),
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              label: Text('Confirma tu contraseña'),
              border: OutlineInputBorder(),
            ),
          ),
          FilledButton.icon(
            onPressed: () => {},
            label: Text('Registrar'),
            icon: Icon(Icons.upgrade_sharp),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('¿Ya tienes una cuenta? Inicia sesión ahora'),
          ),
        ],
      ),
    );
  }
}
