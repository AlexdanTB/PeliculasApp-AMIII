import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  String? urlFoto;
  XFile? foto;

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
    urlFoto = user!.photoURL;
    print('photoURL: $urlFoto');
    print('foto(Xfile): $foto');
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

  void actualizarDatos() {
    String userId = user!.uid;
    actualizarFotoFire(userId);
    FirebaseDatabase.instance
        .ref('usuarios/$userId/')
        .set({
          "correo": correoController.text,
          "fecha_nacimiento": fechaController.text,
          "nick": nickController.text,
        })
        .then((_) {
          final sb_actualizado = SnackBar(
            content: Text('¡Actualización Exitosa!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(sb_actualizado);
        })
        .catchError((error) {
          final sb_error = SnackBar(
            content: Text('No fue posible actualizar, inténtalo nuevamente'),
          );
          print(error);
          print('usuarios/$user/');
          ScaffoldMessenger.of(context).showSnackBar(sb_error);
        });

    editar();
  }

  //FOTO PERFIL//

  void actualizarImgPicked(XFile nuevaFoto) {
    setState(() {
      foto = nuevaFoto;
      print('Foto actualizada: ${foto!.path}');
    });
  }

  Future<void> abrirGaleria(Function actualizarFoto) async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    actualizarFoto(picker);
  }

  Future<void> actualizarFotoFire(String uid) async {
    final storageRef = FirebaseStorage.instance.ref();
    final fotoPerfilRef = storageRef.child("avatars/${uid}.jpg");

    try {
      await fotoPerfilRef.putFile(File(foto!.path));
      urlFoto = await fotoPerfilRef.getDownloadURL();
      await user!.updatePhotoURL(urlFoto);
    } catch (e) {
      print(e);
      final sb_img = SnackBar(content: Text('No fue posible subir la imagen'));
      ScaffoldMessenger.of(context).showSnackBar(sb_img);
    }
  }

  Widget fotoPerfil() {
    return Row(
      children: [
        if (urlFoto != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: foto == null
                ? AssetImage('assets/images/user.png')
                : isEditing
                ? FileImage(File(foto!.path))
                : NetworkImage(urlFoto!),
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
                onPressed: () => abrirGaleria(actualizarImgPicked),
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
                onPressed: () => actualizarDatos(),
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
                TextField(controller: correoController, enabled: false),
                FechaPicker(fechaController, isEditing),
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

  @override
  void dispose() {
    correoController.dispose();
    nickController.dispose();
    super.dispose();
  }
}
