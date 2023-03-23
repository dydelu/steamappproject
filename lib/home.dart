import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'inscription.dart';
import 'accueil.dart';

class Home extends StatefulWidget {
  @override
  _HomeLoginState createState() => _HomeLoginState();
}
class _HomeLoginState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/empty_likes.svg'),
            onPressed: () => Accueil(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('images/trex.jpg')),
              ),
            ),
            ElevatedButton(
              child: Text('Connexion'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Accueil()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Inscription'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Inscription()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
