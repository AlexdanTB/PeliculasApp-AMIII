class Pelicula {
  String titulo;
  String descripcion;
  String imagen;
  String director;
  String lanzamiento;
  int anio;

  Pelicula({
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.director,
    required this.lanzamiento,
    required this.anio,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) {
    return Pelicula(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
      director: json['director'],
      lanzamiento: json['lanzamiento'],
      anio: json['anio'],
    );
  }
}
