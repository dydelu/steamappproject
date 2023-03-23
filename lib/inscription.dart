import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'accueil.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionLoginState createState() => _InscriptionLoginState();
}
class _InscriptionLoginState extends State<Inscription>{

  Color c1 = const Color(0xFF1A2026);
  Color c2 = const Color(0xFF636AF6);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only( left: 30, right: 30, bottom: 25,),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                    children: [
                      Text("Inscription",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
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
                      ),]
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(bottom: 10, top: 15, left: 30, right: 30),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
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
                  border: OutlineInputBorder(),
                  hintText: "Nom d'utilisateur",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(bottom: 10, left: 30, right: 30),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
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
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.only(bottom: 10, left: 30, right: 30),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
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
                  border: OutlineInputBorder(),
                  hintText: 'Mot de passe',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40, left: 30, right: 30),
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
                  border: OutlineInputBorder(),
                  hintText: 'Vérification du mot de passe',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10, top: 15, left: 30, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: c2, //background color of button
                    elevation: 3, //elevation of button
                    padding: EdgeInsets.all(30) //content padding inside button
                ),
                child: Text("S'incrire"),
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
