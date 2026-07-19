class Usuario {
  String id;
  String correo;
  String fecha_nacimiento;
  String nick;

  Usuario({
    required this.id,
    required this.correo,
    required this.fecha_nacimiento,
    required this.nick,
  });

  factory Usuario.fromMap(String id, Map<dynamic, dynamic> map) {
    return Usuario(
      id: id,
      correo: map['correo'],
      fecha_nacimiento: map['fecha_nacimiento'],
      nick: map['nick'],
    );
  }
}
