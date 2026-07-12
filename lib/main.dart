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

class PeliculasApp extends StatelessWidget {
  const PeliculasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(primary: Color.fromRGBO(243, 72, 112, 1)),
      ),
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
