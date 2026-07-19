import 'package:flutter/material.dart';
import 'package:peliculas_app/navigations/bottomnav.dart';
import 'package:peliculas_app/screens/bienvenida_screen.dart';
import 'package:peliculas_app/screens/login_screen.dart';
import 'package:peliculas_app/screens/registro_sceen.dart';

//FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PeliculasApp());
}

class PeliculasApp extends StatefulWidget {
  const PeliculasApp({super.key});

  @override
  State<PeliculasApp> createState() => _PeliculasAppState();
}

class _PeliculasAppState extends State<PeliculasApp> {
  bool modoOscuro = true;

  void cambiarTema() {
    setState(() {
      modoOscuro = !modoOscuro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: modoOscuro
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color.fromRGBO(243, 72, 112, 1),
              ),
            )
          : ThemeData.light(),
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginScreen(),
        "/registro": (context) => RegistroScreen(),
        "/bienvenida": (context) => BienvenidaScreen(),
        "/": (context) => Bottomnav(),
      },
    );
  }
}
