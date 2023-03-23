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
      backgroundColor: c1, //<-- SEE HERE
      appBar: AppBar(
        centerTitle: false,
        title:
            const Text('Accueil', style: TextStyle(fontFamily: 'GoogleSans')),
        backgroundColor: c1,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
                '/Users/julesm/github/steamappproject/assets/icons/like.svg'),
            onPressed: () => Accueil(),
          ),
          IconButton(
            icon: SvgPicture.asset(
                '/Users/julesm/github/steamappproject/assets/icons/whishlist.svg'),
            onPressed: () => Accueil(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: c2,
              ),
              child: const Text('Se deconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
