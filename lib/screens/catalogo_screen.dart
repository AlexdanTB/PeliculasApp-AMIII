import 'dart:convert';

import 'package:flutter/material.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Catálogo'));
  }
}

Future<List> leerPeliculasLocal(context) async {
  String jsonStr = await DefaultAssetBundle.of(
    context,
  ).loadString("assets/data/peliculas2.json");
  return jsonDecode(jsonStr);
}
