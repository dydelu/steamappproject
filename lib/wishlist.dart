import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'accueil.dart';
import 'jeu.dart';
import 'colors.dart';


class Wishlist extends StatefulWidget{
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final wishlist = database.child('wishlist/');

    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Ma Liste de souhaits',
            style: TextStyle(fontFamily: 'GoogleSans')),
        titleSpacing: 0,
        backgroundColor: c1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(
              'assets/icons/close.svg'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Accueil()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            Container(
            child: SvgPicture.asset("assets/icons/empty_whishlist.svg"),
          ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 25,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(children: const [
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Vous n'avez pas liké de contenu. Cliquez sur l'étoile pour en rajouter.",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "GoogleSans",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),],
        ),
      ),
    );
  }
}
