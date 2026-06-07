import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/Catalogo.dart';
import 'package:peliculas_app/screens/Reproductor.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int indice = 0;
  List<Widget> ventanas = [CatalogoScreen(), ReproductorScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ventanas[indice],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          indice = value;
        }),
        currentIndex: indice,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill_rounded),
            label: 'Ver película',
          ),
        ],
      ),
    );
  }
}
