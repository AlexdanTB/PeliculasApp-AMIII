import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/registro_sceen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Image.asset('assets/images/logoicon0.png', height: 60),
            formulario(context),
          ],
        ),
      ),
    );
  }
}

Widget formulario(context) {
  TextEditingController correoC = TextEditingController();
  TextEditingController constrasenaC = TextEditingController();
  return Column(
    children: [
      Text(
        'Iniciar Sesión',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      Text('Correo Electrónico'),
      TextField(
        controller: correoC,
        decoration: InputDecoration(
          label: Text('Ingresa tu correo electrónico'),
          border: OutlineInputBorder(),
          icon: Icon(Icons.mail),
        ),
      ),
      Text('Contraseña'),
      TextField(
        controller: constrasenaC,
        decoration: InputDecoration(
          label: Text('Ingresa tu contraseña'),
          border: OutlineInputBorder(),
          icon: Icon(Icons.remove_red_eye),
        ),
      ),
      FilledButton.icon(
        onPressed: () => login(context),
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
  );
}

void login(BuildContext context) {
  Navigator.pushNamed(context, "/");
}
