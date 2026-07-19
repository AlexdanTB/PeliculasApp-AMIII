import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/registro_sceen.dart';
import 'package:peliculas_app/widgets/fecha_picker.dart';

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
  bool isEditing = false;

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
          fotoPerfil(),
          Text('data'),
          controlesDatos(),
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

  Widget fotoPerfil() {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/user.png'),
          backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        ),
        if (isEditing)
          Column(
            children: [
              IconButton.outlined(
                onPressed: () => {},
                icon: Icon(Icons.camera_alt),
              ),
              IconButton.outlined(
                onPressed: () => {},
                icon: Icon(Icons.photo_library_rounded),
              ),
            ],
          ),
      ],
    );
  }

  Widget controlesDatos() {
    return isEditing
        ? Row(
            children: [
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(4.0),
                  ),
                ),
                onPressed: () => {},
                icon: Icon(Icons.save_outlined),
                label: Text('Actualizar'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(4.0),
                  ),
                ),
                onPressed: () => editar(),
                icon: Icon(Icons.cancel_outlined, size: 20),
                label: Text('Cancelar', style: TextStyle(letterSpacing: 1)),
              ),
            ],
          )
        : ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(4.0),
              ),
            ),
            onPressed: () => editar(),
            icon: Icon(Icons.edit, size: 20),
            label: Text('Editar perfil', style: TextStyle(letterSpacing: 1)),
          );
  }

  Widget formulario() {
    return (Container(
      child: !isLoading
          ? Column(
              children: [
                TextField(controller: correoController, enabled: isEditing),
                FechaPicker(edadContoller, isEditing),
                TextField(controller: nickController, enabled: isEditing),
              ],
            )
          : CircularProgressIndicator(),
    ));
  }

  void editar() {
    setState(() {
      _leerDatosUser();
      isEditing = !isEditing;
    });
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
