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
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            fotoPerfil(),
            controlesDatos(),
            formulario(),
            modoTema(),
            FilledButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(6.0),
                ),
              ),
              onPressed: () => logOut(),
              label: Text('Cerrar Sesión'),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
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
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    actualizarFoto(picker);
  }

  Future<void> abrirCamara(Function actualizarFoto) async {
    final capturado = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    actualizarFoto(capturado);
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
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          urlFoto != null
              ? CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromRGBO(50, 50, 50, 1),
                  backgroundImage: isEditing && foto != null
                      ? FileImage(File(foto!.path))
                      : NetworkImage(urlFoto!),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromRGBO(50, 50, 50, 1),
                  backgroundImage: foto == null
                      ? AssetImage('assets/images/user.png')
                      : FileImage(File(foto!.path)),
                ),
          if (isEditing)
            Column(
              children: [
                IconButton.outlined(
                  onPressed: () => abrirCamara(actualizarImgPicked),
                  icon: Icon(Icons.camera_alt),
                ),
                IconButton.outlined(
                  onPressed: () => abrirGaleria(actualizarImgPicked),
                  icon: Icon(Icons.photo_library_rounded),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget controlesDatos() {
    return isEditing
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: !isLoading
          ? Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(controller: correoController, enabled: false),
                TextField(
                  controller: nickController,
                  enabled: isEditing,
                  decoration: InputDecoration(icon: Icon(Icons.person)),
                ),
                FechaPicker(fechaController, isEditing),
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
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Text('Modo oscuro'),
          IconButton.filledTonal(
            onPressed: () => {},
            icon: Icon(Icons.dark_mode_sharp, size: 20),
          ),
        ],
      ),
    );
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }

  @override
  void dispose() {
    correoController.dispose();
    nickController.dispose();
    super.dispose();
  }
}
