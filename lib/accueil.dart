import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'jeu.dart';
import 'wishlist.dart';
import 'likes.dart';


class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Wishlist'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()),);
              },
            ),
            ElevatedButton(
              child: Text('Likes'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Likes()),);
              },
            ),
             ElevatedButton(
              child: Text('CECI EST UN JEU'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Jeu()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Se deconnecter'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
              },
            ),
          ],
        ),
      ),
    );
  }
}