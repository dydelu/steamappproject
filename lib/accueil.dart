import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'jeu.dart';
import 'wishlist.dart';
import 'likes.dart';

class Accueil extends StatelessWidget {
  Color c1 = const Color(0xFF1A2026);
  Color c2 = const Color(0xFF636AF6);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Accueil'),
        backgroundColor: c1,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/empty_likes.svg',
            ),
            onPressed: null, //do something,
            color: Colors.red,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('CECI EST UN JEU'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Jeu()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: c2,
              ),
            ),
            ElevatedButton(
              child: const Text('Se deconnecter'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: c2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
