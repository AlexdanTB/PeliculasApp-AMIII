import 'package:flutter/material.dart';
import 'package:peliculas_app/navigations/bottomnav.dart';
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
            logoiconrow(),
            Text(
              'Iniciar Sesión',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text('Correo Electrónico'),
            TextField(
              decoration: InputDecoration(
                label: Text('Ingresa tu correo electrónico'),
                border: OutlineInputBorder(),
                icon: Icon(Icons.mail),
              ),
            ),
            Text('Contraseña'),
            TextField(
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
        ),
      ),
    );
  }
}

Widget logoiconrow() {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      Image.asset("assets/images/icon.png", height: 50),
      Text(
        'Cinext+',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Color.fromRGBO(255, 88, 116, 1),
        ),
      ),
    ],
  ));
}

void login(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Bottomnav()),
  );
}
