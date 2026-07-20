import 'package:firebase_auth/firebase_auth.dart';
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
          spacing: 20,
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
    spacing: 20,
    children: [
      Text(
        'Iniciar Sesión',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      TextField(
        controller: correoC,
        decoration: InputDecoration(
          label: Text('Ingresa tu correo electrónico'),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(75, 75, 75, 1),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(163, 16, 75, 1),
              width: 1.0,
            ),
          ),
          prefixIcon: Icon(Icons.mail),
        ),
      ),
      TextField(
        controller: constrasenaC,
        decoration: InputDecoration(
          label: Text('Ingresa tu contraseña'),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(75, 75, 75, 1),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(163, 16, 75, 1),
              width: 1.0,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.remove_red_eye),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            FilledButton.icon(
              onPressed: () => login(context, correoC, constrasenaC),
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
    ],
  );
}

Future<void> login(context, _correo, _contrasena) async {
  String correo = _correo.text;
  String contrasena = _contrasena.text;
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
