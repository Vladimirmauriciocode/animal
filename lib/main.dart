import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoo_app/screens/login_screen.dart';
import 'package:zoo_app/screens/animal_list_screen.dart';

void main() async {
  // Asegurar que Flutter está inicializado antes de ejecutar código asíncrono
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase antes de ejecutar la aplicación
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar la etiqueta de debug en la app
      title: 'Zoo App', // Título de la app
      theme: ThemeData(
        primarySwatch: Colors.green, // Definir un color de tema
      ),
      home: AuthWrapper(), // Determina qué pantalla mostrar según el estado de autenticación
    );
  }
}

/// AuthWrapper decide si mostrar la pantalla de login o la pantalla principal según la autenticación
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Escuchar cambios en la autenticación
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Mostrar un loader mientras carga Firebase
        } else if (snapshot.hasData) {
          return AnimalListScreen(); // Si el usuario está autenticado, mostrar la lista de animales
        } else {
          return LoginScreen(); // Si no está autenticado, mostrar la pantalla de login
        }
      },
    );
  }
}
