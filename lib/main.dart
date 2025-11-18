import 'package:flutter/material.dart';
import 'package:flutter_project_elyamani/screens/home.page.dart';
import 'package:flutter_project_elyamani/screens/login.page.dart';
import 'package:flutter_project_elyamani/screens/register.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/*
void main() {
  runApp(MyApp());
}
*/

Future<void> main() async {
  // Rendez la fonction 'main' async
  WidgetsFlutterBinding.ensureInitialized(); // Assurez l'initialisation des widgets

  // --- Initialiser Firebase ---
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: 'Flutter application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
