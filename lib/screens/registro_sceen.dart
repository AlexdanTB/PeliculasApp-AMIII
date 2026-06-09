import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/login_screen.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  DateTime? _fecha;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 10,
        children: [
          logoiconrow(),
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
          TextField(
            readOnly: true,
            controller: edadContoller,
            decoration: InputDecoration(icon: Icon(Icons.date_range_rounded)),
            keyboardType: TextInputType.datetime,
            onTap: () => _fechanacimiento(context),
          ),
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

  Future<void> _fechanacimiento(BuildContext context) async {
    DateTime? fechapicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (fechapicked != null && fechapicked != _fecha) {
      setState(() {
        _fecha = fechapicked;

        String d = fechapicked.day.toString().padLeft(2, '0');
        String m = fechapicked.month.toString().padLeft(2, '0');
        String y = fechapicked.year.toString();

        edadContoller.text = '$d/$m/$y';
      });
    }
  }
}

TextEditingController edadContoller = TextEditingController();
