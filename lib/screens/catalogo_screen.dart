import 'dart:convert';

import 'package:flutter/material.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text("${item['titulo']}"),
              subtitle: Text("${item['director']}"),
              leading: Image.network(item['imagen']),
            );
          },
        );
      } else {
        return (CircularProgressIndicator());
      }
    },
  );
}
