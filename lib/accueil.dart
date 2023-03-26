import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steamappproject/jeu.dart';
import 'wishlist.dart';
import 'likes.dart';
import 'colors.dart';
import 'model/JeuDetails.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  late Future<List<GamesDetails>> _futureGames;

  @override
  void initState() {
    super.initState();
    _futureGames = fetchAllGamesDetails();
  }

  Future<List<GamesDetails>> fetchAllGamesDetails() async {
    final List<int> appids = await fetchAllGames();
    final List<GamesDetails> gamesDetails = await fetchInfos(appids);
    return gamesDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Accueil',
          style: TextStyle(fontFamily: 'GoogleSans'),
        ),
        titleSpacing: 15,
        backgroundColor: c1,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: SvgPicture.asset('assets/icons/like.svg'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Likes()),
                );
              }),
          IconButton(
            icon: SvgPicture.asset('assets/icons/whishlist.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<GamesDetails>>(
        future: _futureGames,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<GamesDetails> gamesDetails = snapshot.data!;
            return ListView.builder(
              itemCount: gamesDetails.length < 10 ? gamesDetails.length : 10,
              itemBuilder: (context, index) {
                final GamesDetails gameDetails = gamesDetails[index];
                return Card(
                  margin: const EdgeInsets.all(5),
                  color: c3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100.0,
                            height: 100.0,
                            child: Image.network(gameDetails.headerImage),
                          ),
                          Container(
                            width: 190.0,
                            height: 100.0,
                            padding: const EdgeInsets.only(
                                left: 5, bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gameDetails.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Price: ${gameDetails.price}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Publisher: ${gameDetails.publisher}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 80.0,
                            height: 100.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                backgroundColor: c2,
                                elevation: 0,
                                padding: const EdgeInsets.all(2),
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                              child: const Text(
                                'En savoir plus',
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Jeu()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text("Veuillez patienter"),
                ]),
          );
        },
      ),
    );
  }
}
