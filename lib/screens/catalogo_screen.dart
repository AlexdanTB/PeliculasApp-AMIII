import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/detalle_screen.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Expanded(child: listaPeliculas(context))]),
    );
  }
}

Future<List<dynamic>> leerPeliculasFire() async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('peliculas/').get();
  if (!snapshot.exists) {
    print("no hay data");
    return [];
  } else {
    print("Sí hay data");
    final mapeli = Map.from(snapshot.value as Map);
    return mapeli.values.toList();
  }
}

/*
Future<List> leerPeliculasLocal(BuildContext context) async {
  String jsonStr = await DefaultAssetBundle.of(
    context,
  ).loadString("assets/data/peliculas2.json");
  return jsonDecode(jsonStr)['peliculas'];
}
*/

Widget listaPeliculas(BuildContext context) {
  return FutureBuilder(
    future: leerPeliculasFire(),
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
            //dataafire(pelicula);
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetallePelicula(peliculadetail: pelicula),
                ),
              ),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(5),
                margin: EdgeInsetsDirectional.symmetric(vertical: 3),
                child: Column(
                  spacing: 6,
                  children: [
                    Image.network('${pelicula['imagen']}', height: 150),
                    Flexible(child: Text('${pelicula['titulo']}')),
                  ],
                ),
              ),
            );
          },
        ));
      } else {
        return Center(child: Container(child: (CircularProgressIndicator())));
      }
    },
  );
}

/* Temporal: json a firebase
Future<void> dataafire(pelicula) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref(
    "peliculas/${pelicula['id']}",
  );

  await ref.set(pelicula);
}
*/
