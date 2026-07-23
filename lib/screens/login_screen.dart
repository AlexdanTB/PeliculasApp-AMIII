import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/registro_sceen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool mostrarPass = true;
  TextEditingController correoC = TextEditingController();
  TextEditingController constrasenaC = TextEditingController();

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

  Widget formulario(context) {
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
          obscureText: mostrarPass,
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
              onPressed: () {
                setState(() {
                  mostrarPass = !mostrarPass;
                });
              },
              icon: mostrarPass
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.visibility_off_rounded),
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
      String msg = 'Credenciales incorrectas';
      print('###ERROR: $e');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        msg = 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        msg = 'Contraseña incorrecta';
      }
      final sb_error = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(sb_error);
    }
  }

  @override
  void dispose() {
    constrasenaC.dispose();
    correoC.dispose();
    super.dispose();
  }
}
