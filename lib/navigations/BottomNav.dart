import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/catalogo_screen.dart';
import 'package:peliculas_app/screens/perfil_screen.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int indice = 0;
  List<Widget> ventanas = [CatalogoScreen(), PerfilScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logoicon0.png', height: 30),
      ),
      body: ventanas[indice],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(243, 72, 112, 1),
        onTap: (value) => setState(() {
          indice = value;
        }),
        currentIndex: indice,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
