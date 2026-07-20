import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/reproductor_screen.dart';
import 'package:peliculas_app/widgets/reproductor_yt.dart';

class DetallePelicula extends StatefulWidget {
  final Map peliculadetail;
  const DetallePelicula({super.key, required this.peliculadetail});

  @override
  State<DetallePelicula> createState() => _DetallePeliculaState();
}

class _DetallePeliculaState extends State<DetallePelicula> {
  bool verT = false;

  void verTrailer() {
    setState(() {
      verT = !verT;
    });
  }

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
            verT
                ? ReproductorYt(widget.peliculadetail['trailer_url'])
                : Image.network(widget.peliculadetail['imagen']),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  btnMirarAhora(context, widget.peliculadetail['video_url']),
                  btnVerTrailer(verTrailer),
                ],
              ),
            ),
            Text(
              widget.peliculadetail['titulo'],
              style: TextStyle(
                fontWeight: FontWeight(800),
                fontSize: 25,
                letterSpacing: -0.5,
              ),
            ),
            info1(),
            Text(
              widget.peliculadetail['descripcion'],
              style: TextStyle(fontSize: 13, fontWeight: FontWeight(300)),
            ),
            generosL(widget.peliculadetail['genero']),
          ],
        ),
      ),
    );
  }

  Widget info1() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        spacing: 20,
        children: [valoracion(), year(), clasificacion()],
      ),
    );
  }

  Widget valoracion() {
    final val = widget.peliculadetail['valoracion'];
    return Container(
      color: Color.fromRGBO(45, 30, 43, 1),
      child: Row(
        spacing: 3,
        children: [
          Icon(Icons.star, size: 16, color: Color.fromRGBO(237, 235, 132, 1)),
          Text(
            val.toString().length < 2 ? '${val.toString()}.0' : val.toString(),
            style: TextStyle(fontWeight: FontWeight(700)),
          ),
        ],
      ),
    );
  }

  Widget year() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      color: Color.fromRGBO(51, 45, 53, 1),
      child: Text(
        widget.peliculadetail['anio'].toString(),
        style: TextStyle(fontWeight: FontWeight(700)),
      ),
    );
  }

  Widget clasificacion() {
    final clasificacionE = widget.peliculadetail['clasificacion_edad'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      color: Color.fromRGBO(11, 0, 14, 1),
      child: Text(
        clasificacionE > 0 ? '+${clasificacionE.toString()}' : 'G',
        style: TextStyle(
          fontWeight: FontWeight(700),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget btnMirarAhora(context, video) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(4.0),
        ),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReproductorScreen(url_video: video),
        ),
      ),
      icon: Icon(Icons.play_arrow, size: 30),
      label: Text('MIRAR AHORA', style: TextStyle(letterSpacing: 1)),
    );
  }

  Widget btnVerTrailer(Function verTrailer) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(4.0),
        ),
      ),
      icon: Icon(Icons.play_circle_fill),
      onPressed: () => verTrailer(),
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
}
