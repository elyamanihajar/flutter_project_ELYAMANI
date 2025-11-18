import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool passwordVisibility = false;

  String? _validateEmail(String? value) {
    if ((value == null) || (value.isEmpty)) return 'Please enter your Email';

    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regEx = RegExp(emailPattern);

    if (!regEx.hasMatch(value)) return 'Enter a valid Email Adress';

    return null;
  }

  String? _validatePass(String? value) {
    if ((value == null) || (value.isEmpty)) return "Please enter your password";
    if (value.length < 6) {
      return "Password must be at least 6 charcters long";
    }
    return null;
  }

  Future<void> SignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim(),
          );
      if (userCredential.user != null) {
        print("Signed in : ${userCredential.user?.email}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Sign-in successful!")));
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      print("CODE ERREUR RECU : ${e.code}");
      String message;
      switch (e.code) {
        case 'invalid-credential':
          message = "Email ou mot de passe incorrect.";
          break;
        case 'user-not-found':
          message = "No user found for that email.";
          break;
        case 'wrong-password':
          message = "The email address is invalid.";
          break;
        case 'user-disabled':
          message = "This user account has been disabled.";
          break;
        case 'too-many-requests':
          message = "Too many attempts. Please try again later.";
          break;
        default:
          message = "An error occured. Try again.";
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      print("FirebaseAuthException: $message");
    } on SocketException catch (e) {
      String message = "Network error: Please check your internet connexion.";

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      print("SocketException:$e");
    } catch (e) {
      String message = "An unexpected error occured.";

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      print("Unknown error:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login Page",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        // --- Utilisation d'un SingleChildScrollView pour éviter le débordement du clavier ---
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("images/logoWelcome.png", height: 200, width: 200),
                SizedBox(height: 10),
                Text(
                  "Welcome back !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.brown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.teal),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 30),
                TextFormField(
                  obscureText: !passwordVisibility,
                  controller: _passController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.password, color: Colors.teal),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                      icon: Icon(
                        passwordVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: _validatePass,
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    SignIn();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.brown,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    "Don't have an account ? Register here",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
