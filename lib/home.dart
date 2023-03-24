import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'inscription.dart';
import 'accueil.dart';
import 'colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeLoginState createState() => _HomeLoginState();
}

class _HomeLoginState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              '/Users/julesm/github/steamappproject/assets/images/bg.jpg'),
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
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Accueil()),
                  );
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
          ],
        ),
      ),
    );
  }
}
