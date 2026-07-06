import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/reproductor_screen.dart';

class DetallePelicula extends StatelessWidget {
  final Map peliculadetail;
  const DetallePelicula({super.key, required this.peliculadetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logoicon0.png', height: 30),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Image.network(peliculadetail['imagen']),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                spacing: 5,
                children: [
                  btnMirarAhora(),
                  btnVerTrailer(context, peliculadetail['trailer_url']),
                ],
              ),
            ),
            Text(
              peliculadetail['titulo'],
              style: TextStyle(
                fontWeight: FontWeight(800),
                fontSize: 25,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              peliculadetail['descripcion'],
              style: TextStyle(fontSize: 13, fontWeight: FontWeight(300)),
            ),
            generosL(peliculadetail['genero']),
          ],
        ),
      ),
    );
  }
}

Widget btnMirarAhora() {
  return FilledButton.icon(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(4.0),
      ),
    ),
    onPressed: () => {},
    icon: Icon(Icons.play_arrow, size: 30),
    label: Text('MIRAR AHORA', style: TextStyle(letterSpacing: 1)),
  );
}

Widget btnVerTrailer(context, String trailer) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(4.0),
      ),
    ),
    icon: Icon(Icons.play_circle_fill),
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReproductorScreen(url_video: trailer),
      ),
    ),
    label: Text('Ver Trailer'),
  );
}

Widget generosL(List<dynamic> p) {
  return Container(
    height: 27,
    padding: EdgeInsets.all(2),
    child: ListView.separated(
      separatorBuilder: (context, index) => SizedBox(width: 10),
      scrollDirection: Axis.horizontal,
      itemCount: p.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        color: Color.fromRGBO(11, 0, 14, 1),
        child: Text(
          p[index].toString().toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight(600),
            letterSpacing: 0.5,
          ),
        ),
      ),
    ),
  );
}
