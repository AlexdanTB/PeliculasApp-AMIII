import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/bienvenida_screen.dart';

void main() {
  runApp(PeliculasApp());
}

class PeliculasApp extends StatelessWidget {
  const PeliculasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(primary: Color.fromRGBO(243, 72, 112, 1)),
      ),
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BienvenidaScreen());
  }
}
