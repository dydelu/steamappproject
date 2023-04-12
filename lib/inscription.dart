import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'accueil.dart';
import 'colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionLoginState createState() => _InscriptionLoginState();
}

class _InscriptionLoginState extends State<Inscription> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  static Future<User?> registerUsingEmailPassword({  //https://firebase.google.com/docs/auth/flutter/password-auth
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
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
                    "Inscription",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 350,
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Veuillez saisir ces différentes informations afin que vos listes soient sauvegardées.",
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
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  bottom: 10, top: 15, left: 30, right: 30),
              child: TextField(
                controller: _nameTextController,
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
                  hintText: "Nom d'utilisateur",
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
              child: TextField(
                controller: _emailTextController,
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
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
              child: TextField(
                controller: _passwordTextController,
                textAlign: TextAlign.center,
                obscureText: true,
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
                  hintText: 'Mot de passe',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 30, right: 30),
              child: TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
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
                  hintText: 'Vérification du mot de passe',
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
                child: const Text("S'incrire"),
                onPressed: () async {
                  User? user = await registerUsingEmailPassword(
                      name: _nameTextController.text,
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Accueil()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
