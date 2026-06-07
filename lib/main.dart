import 'package:flutter/material.dart';
import 'package:peliculas_app/navigations/StackNavigation.dart';

void main() {
  runApp(PeliculasApp());
}

class PeliculasApp extends StatelessWidget {
  const PeliculasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Cuerpo());
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stacknavigation());
  }
}
