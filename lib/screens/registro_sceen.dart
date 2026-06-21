import 'package:flutter/material.dart';

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
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(5),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logoicon0.png', height: 50),
            formulario(context),
          ],
        ),
      ),
    );
  }

  Widget formulario(context) {
    return Column(
      children: [
        Text(
          'Crea tu cuenta',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text('Nombre de usuario'),
        TextField(
          decoration: InputDecoration(
            label: Text('Escribe tu nick/usuario'),
            border: OutlineInputBorder(),
            icon: Icon(Icons.person_pin),
          ),
        ),
        Text('Correo Electrónico'),
        TextField(
          decoration: InputDecoration(
            label: Text('Ingresa tu correo electrónico'),
            border: OutlineInputBorder(),
            icon: Icon(Icons.mail),
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
          onPressed: () => registrar(context),
          label: Text('Registrarme'),
          icon: Icon(Icons.app_registration_rounded),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('¿Ya tienes una cuenta? Inicia sesión ahora'),
        ),
      ],
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

TextEditingController usuarioC = TextEditingController();
TextEditingController correoC = TextEditingController();
TextEditingController passC = TextEditingController();
TextEditingController passconfC = TextEditingController();
TextEditingController edadContoller = TextEditingController();

void registrar(context) {
  Navigator.pop(context);
}
