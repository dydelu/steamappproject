import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steamappproject/jeu.dart';
import 'inscription.dart';
import 'accueil.dart';
import 'colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeLoginState createState() => _HomeLoginState();
}

class _HomeLoginState extends State<Home> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Pas d'utilisateur associé a cette adresse email");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 25,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(children: const [
                  Text(
                    "Bienvenue !",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Veuillez vous connecter ou créer un nouveau compte pour utiliser l'application.",
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: c2,
                      width: 1.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.shade900,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: const OutlineInputBorder(),
                  hintText: 'E-mail',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 60, top: 15, left: 30, right: 30),
              child: TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.blueGrey.shade900,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.shade900,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: c2,
                      width: 1.0,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: const OutlineInputBorder(),
                  hintText: 'Mot de passe',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 15, left: 30, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: c2, //background color of button
                    elevation: 3, //elevation of button
                    padding:
                        const EdgeInsets.all(30) //content padding inside button
                    ),
                child: const Text('Se connecter'),
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Accueil()),
                    );
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, //background color of button
                    side: BorderSide(width: 3, color: c2),
                    elevation: 3, //elevation of button
                    padding:
                        const EdgeInsets.all(30) //content padding inside button
                    ),
                child: const Text('Créer un nouveau compte'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inscription()),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 15, left: 30, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: c2, //background color of button
                    elevation: 3, //elevation of button
                    padding:
                        const EdgeInsets.all(30) //content padding inside button
                    ),
                child: const Text('ADMIN'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Accueil()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
