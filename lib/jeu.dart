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

  @override
  Widget build(BuildContext context) {
    final listeJeu = database.child("wishlist/");

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
                'assets/icons/like.svg'),
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
          IconButton(
            icon: SvgPicture.asset(
                'assets/icons/whishlist.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
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
