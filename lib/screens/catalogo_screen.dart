import 'dart:convert';

import 'package:flutter/material.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logoicon0.png', height: 30),
      ),
      body: Column(
        children: [
          Text('Catálogo de películas'),
          Expanded(child: listaPeliculas(context)),
        ],
      ),
    );
  }
}

Future<List> leerPeliculasLocal(BuildContext context) async {
  String jsonStr = await DefaultAssetBundle.of(
    context,
  ).loadString("assets/data/peliculas2.json");
  return jsonDecode(jsonStr)['peliculas'];
}

Widget listaPeliculas(BuildContext context) {
  return FutureBuilder(
    future: leerPeliculasLocal(context),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        return (GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final pelicula = data[index];
            return Container(
              height: 200,
              padding: EdgeInsets.all(5),
              margin: EdgeInsetsDirectional.symmetric(vertical: 3),
              child: Column(
                spacing: 6,
                children: [
                  Image.network('${pelicula['imagen']}', height: 150),
                  Text('${pelicula['titulo']}'),
                ],
              ),
            );
          },
        ));
      } else {
        return (CircularProgressIndicator());
      }
    },
  );
}
