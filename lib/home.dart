import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'inscription.dart';
import 'accueil.dart';

class Home extends StatelessWidget{
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('ConnexionASDASD'),
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
