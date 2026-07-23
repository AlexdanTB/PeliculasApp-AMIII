import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  DateTime? _fecha;
  bool mostrarPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(5),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logoicon0.png', height: 50),
            formulario(context),
            btns(),
          ],
        ),
      ),
    );
  }

  Widget formulario(context) {
    return Column(
      spacing: 15,
      children: [
        Text(
          'Crea tu cuenta',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: usuarioC,
          decoration: InputDecoration(
            label: Text('Escribe tu nick/usuario'),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(75, 75, 75, 1),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(163, 16, 75, 1),
                width: 1.0,
              ),
            ),
            icon: Icon(Icons.person_pin),
          ),
        ),
        TextField(
          controller: correoC,
          decoration: InputDecoration(
            label: Text('Ingresa tu correo electrónico'),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(75, 75, 75, 1),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(163, 16, 75, 1),
                width: 1.0,
              ),
            ),
            icon: Icon(Icons.mail),
          ),
        ),
        TextField(
          readOnly: true,
          controller: edadContoller,
          decoration: InputDecoration(
            label: Text('Selecciona tu fecha de nacimiento'),
            icon: Icon(Icons.date_range_rounded),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(75, 75, 75, 1),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(163, 16, 75, 1),
                width: 1.0,
              ),
            ),
          ),
          keyboardType: TextInputType.datetime,
          onTap: () => _fechanacimiento(context),
        ),
        TextField(
          obscureText: mostrarPass,
          controller: passC,
          decoration: InputDecoration(
            label: Text('Ingresa tu contraseña'),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(75, 75, 75, 1),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(163, 16, 75, 1),
                width: 1.0,
              ),
            ),
            icon: Icon(Icons.lock),
          ),
        ),
        TextField(
          obscureText: mostrarPass,
          controller: passconfC,
          decoration: InputDecoration(
            label: Text('Confirma tu contraseña'),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(75, 75, 75, 1),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(163, 16, 75, 1),
                width: 1.0,
              ),
            ),
            icon: Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  mostrarPass = !mostrarPass;
                });
              },
              icon: mostrarPass
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.visibility_off_rounded),
            ),
          ),
        ),
      ],
    );
  }

  Widget btns() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          FilledButton.icon(
            onPressed: () => registrar(context),
            label: Text('Registrarme'),
            icon: Icon(Icons.app_registration_rounded),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('¿Ya tienes una cuenta? Inicia sesión ahora'),
          ),
        ],
      ),
    );
  }

  Future<void> _fechanacimiento(BuildContext context) async {
    DateTime? fechapicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (fechapicked != null && fechapicked != _fecha) {
      setState(() {
        _fecha = fechapicked;

        String d = fechapicked.day.toString().padLeft(2, '0');
        String m = fechapicked.month.toString().padLeft(2, '0');
        String y = fechapicked.year.toString();

        edadContoller.text = '$d/$m/$y';
      });
    }
  }

  TextEditingController usuarioC = TextEditingController();
  TextEditingController correoC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController passconfC = TextEditingController();
  TextEditingController edadContoller = TextEditingController();

  Future<void> registrar(context) async {
    String usuario = usuarioC.text;
    String correo = correoC.text;
    String contrasena = passC.text;
    String contrasenac = passconfC.text;

    if (usuario.isNotEmpty &&
        correo.isNotEmpty &&
        edadContoller.text.isNotEmpty &&
        contrasena.isNotEmpty) {
      if (contrasena == contrasenac) {
        try {
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: correo,
                password: contrasena,
              );

          guardarDatosUser(usuario, correo, edadContoller.text);

          final registroExitoso = SnackBar(
            content: Text('¡Registro Exitoso! Inicia sesión ahora'),
          );
          ScaffoldMessenger.of(context).showSnackBar(registroExitoso);
          Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        final noCoincideSB = SnackBar(
          content: Text('La contraseña no coincide'),
        );
        ScaffoldMessenger.of(context).showSnackBar(noCoincideSB);
      }
    } else {
      final datosIncompletos = SnackBar(
        content: Text('Datos incompletos, llena todos los campos'),
      );
      ScaffoldMessenger.of(context).showSnackBar(datosIncompletos);
    }
  }

  Future<void> guardarDatosUser(usuario, correo, fechan) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/$uid");

      await ref.set({
        "nick": usuario,
        "correo": correo,
        "fecha_nacimiento": fechan,
      });
    }
  }

  @override
  void dispose() {
    usuarioC.dispose();
    correoC.dispose();
    passC.dispose();
    passconfC.dispose();
    edadContoller.dispose();
    super.dispose();
  }
}
