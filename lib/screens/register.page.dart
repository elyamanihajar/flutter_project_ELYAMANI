import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // --- Contrôleurs pour les nouveaux champs ---
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- États de visibilité pour les deux champs de mot de passe ---
  bool passwordVisibility = false;
  bool confirmPasswordVisibility = false;

  // --- Validation email ---
  String? _validateEmail(String? value) {
    if ((value == null) || (value.isEmpty)) return 'Please enter your Email';

    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regEx = RegExp(emailPattern);

    if (!regEx.hasMatch(value)) return 'Enter a valid Email Adress';

    return null;
  }

  // --- Validation mot de passe ---
  String? _validatePass(String? value) {
    if ((value == null) || (value.isEmpty)) return "Please enter your password";
    if (value.length < 6) {
      return "Password must be at least 6 charcters long";
    }
    return null;
  }

  // --- Validation pour le nom d'utilisateur ---
  String? _validateUsername(String? value) {
    if ((value == null) || (value.isEmpty)) return "Please enter your username";
    return null;
  }

  // --- Validation pour la confirmation ---
  String? _validateConfirmPass(String? value) {
    if ((value == null) || (value.isEmpty))
      return "Please confirm your password";
    if (value != _passController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  // --- Methode SignUp Firebase
  Future SignUp() async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim(),
          );
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code.contains("weak-password")) {
        Fluttertoast.showToast(
          msg: "Votre mot de passe doit contenir au moins 6 caractères.",
        );
      }
      if (e.code.contains("invalid-email")) {
        Fluttertoast.showToast(msg: "Votre email n'a pas un format valide.");
      }
      if (e.code.contains("email-already-in-use")) {
        Fluttertoast.showToast(msg: "Cette adresse mail est déjà utilisée");
      }
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // --- Titre de la page mis à jour ---
        title: Text(
          "Register Page",
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
                Image.asset(
                  "images/register.png",
                  height: 150,
                  width: 150,
                ), // Taille réduite
                SizedBox(height: 10),
                // --- Texte d'accueil mis à jour ---
                Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.brown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),

                // --- Nouveau champ : Username ---
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.teal),
                  ),
                  validator: _validateUsername,
                ),
                SizedBox(height: 20),

                // --- Champ Email (identique à la page de login) ---
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
                SizedBox(height: 20), // Espacement réduit
                // --- Champ Password (identique à la page de login) ---
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
                SizedBox(height: 20), // Espacement réduit
                // --- Nouveau champ : Confirm Password ---
                TextFormField(
                  obscureText: !confirmPasswordVisibility,
                  controller: _confirmPassController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.password, color: Colors.teal),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          confirmPasswordVisibility =
                              !confirmPasswordVisibility;
                        });
                      },
                      icon: Icon(
                        confirmPasswordVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: _validateConfirmPass,
                ),
                SizedBox(height: 40), // Espacement réduit
                // --- Bouton d'action mis à jour ---
                ElevatedButton(
                  onPressed: () {
                    SignUp();
                    /*
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Processing Registration")),
                      );
                      // --- Navigation retour vers la page de login après inscription ---
                      Navigator.pop(context);
                    }
*/
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.brown,
                  ),
                  child: Text(
                    'Register', // Texte du bouton mis à jour
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                SizedBox(height: 30),

                // --- Bouton de navigation mis à jour ---
                TextButton(
                  onPressed: () {
                    // --- Revient simplement à la page précédente (login) ---
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Already have an account? Login here",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 17),
                  ),
                ),
                SizedBox(height: 20), // Ajout d'un padding en bas
              ],
            ),
          ),
        ),
      ),
    );
  }
}
