import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steamappproject/accueil.dart';
import 'package:steamappproject/jeu.dart';
import 'home.dart';
import 'colors.dart';
import 'wishlist.dart';
import 'likes.dart';


class Jeu extends StatefulWidget {
  @override
  _JeuState createState() => _JeuState();
}

class _JeuState extends State<Jeu> {
  final database = FirebaseDatabase.instance.ref();

  _JeuState();

  initState(){
    super.initState();
  }

  // Defining a variable for storing click state
  bool isPressed = false;
  bool isPressed2 = false;

  // Click function for changing the state on click
  _pressed(final listeJeu) {
    var newVal = true;
    if (isPressed) {
      newVal = false;
          listeJeu.child('Likes')
          .push()
          .set({'nom': 'JeuBlabla', 'price': 5 });
    } else {
      newVal = true;
    }
    // This function is required for changing the state.
    // Whenever this function is called it refresh the page with new value
    setState(() {
      isPressed = newVal;
    });
  }
    _pressed2(final listeJeu) {
      var newVal2 = true;
      if(isPressed2) {
        newVal2 = false;
        listeJeu.child('Wishlist')
            .push()
            .set({'nom': 'JeuBlabla', 'price': 5000 });
      } else {
        newVal2 = true;
      }
      setState((){
        isPressed2 = newVal2;

      });
  }

  @override
  Widget build(BuildContext context) {
    final listeJeu = database.child("Profil/");

    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Détail du jeu',
            style: TextStyle(fontFamily: 'GoogleSans')),
        titleSpacing: 0,
        backgroundColor: c1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(
              'assets/icons/back.svg'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Accueil()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
      isPressed2  ? "assets/icons/like.svg" : "assets/icons/like_full.svg",
          fit: BoxFit.fill,
            ),
          onPressed: () async {
                try {
                  _pressed2(listeJeu);
                  print('ajoute');
                }catch(e){
                  print('error $e');
                }
              }
          ),
          IconButton(
            icon: SvgPicture.asset(
              isPressed  ? "assets/icons/whishlist.svg" : "assets/icons/whishlist_full.svg",
              fit: BoxFit.fill,
            ),
              onPressed: () async {
                try {
                  _pressed(listeJeu);
                  print('ajoute');
                }catch(e){
                  print('error $e');
                }
              }
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 15, left: 30, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: c2, //background color of button
                    elevation: 3, //elevation of button
                    padding:
                    const EdgeInsets.all(30) //content padding inside button
                ),
                child: const Text('test DB'),
                onPressed: () async {
                  try {
                   await listeJeu.set({
                      'nom': 'TEST', 'price': 3
                    });
                   print('ajoute');
                  }catch(e){
                    print('error $e');
                  }
                      }
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
