import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/usuario.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late Map dataUsuario;

  @override
  void initState() {
    leerDatosUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/user.png'),
            backgroundColor: Color.fromRGBO(50, 50, 50, 1),
          ),
          Text('data'),
          formulario(),
        ],
      ),
    );
  }
}

Future<void> leerDatosUser() async {
  User? user = FirebaseAuth.instance.currentUser;
  String userId = user!.uid;
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('usuarios/$userId').get();
  if (snapshot.exists) {
    print(snapshot.value);
    final map = snapshot.value as Map;

    Usuario usuario = Usuario.fromMap(snapshot.key!, map);
    print('Usuario mapeado: ${usuario}');
  } else {
    print('No data available. ${userId}');
  }
}

Widget formulario() {
  return (Container(
    child: Column(children: [TextField(), TextField(), TextField()]),
  ));
}
