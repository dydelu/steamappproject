import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        title:
            const Text('Accueil', style: TextStyle(fontFamily: 'GoogleSans')),
        titleSpacing: 15,
        backgroundColor: c1,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
                '/Users/julesm/github/steamappproject/assets/icons/like.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Likes()),
              );
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
                '/Users/julesm/github/steamappproject/assets/icons/whishlist.svg'),
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
              itemCount: gamesDetails.length,
              itemBuilder: (context, index) {
                final GamesDetails gameDetails = gamesDetails[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(gameDetails.headerImage),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gameDetails.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Price: ${gameDetails.price}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Publisher: ${gameDetails.publisher}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
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
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
