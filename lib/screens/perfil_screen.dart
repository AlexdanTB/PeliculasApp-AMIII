import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late Map dataUsuario;
  TextEditingController correoController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController nickController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _leerDatosUser();
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
          modoTema(),
        ],
      ),
    );
  }

  Future<void> _leerDatosUser() async {
    setState(() => isLoading = true);
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('usuarios/$userId').get();
    if (snapshot.exists && snapshot.value != null) {
      Map<dynamic, dynamic> usuarioData = Map<dynamic, dynamic>.from(
        snapshot.value as Map,
      );
      setState(() {
        correoController.text = usuarioData['correo'];
        fechaController.text = usuarioData['fecha_nacimiento'];
        nickController.text = usuarioData['nick'];
        isLoading = false;
      });
      print(usuarioData);
    } else {
      isLoading = false;
      print('No data available. ${userId}');
    }
  }

  Widget formulario() {
    return (Container(
      child: !isLoading
          ? Column(
              children: [
                TextField(controller: correoController),
                TextField(controller: fechaController),
                TextField(controller: nickController),
              ],
            )
          : CircularProgressIndicator(),
    ));
  }

  Widget modoTema() {
    return Row(
      children: [
        Text('Modo oscuro'),
        IconButton.filled(
          onPressed: () => {},
          icon: Icon(Icons.dark_mode_sharp),
        ),
      ],
    );
  }
}
