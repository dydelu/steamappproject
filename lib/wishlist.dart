import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'accueil.dart';
import 'models/JeuDetails.dart';
import 'jeu.dart';
import 'colors.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late Future<List<GamesDetails>> _futureWishlistGames;
  final database = FirebaseDatabase.instance.ref();
  final wishlist = FirebaseDatabase.instance.ref().child("Wishlist");
  List<String> _gameIDs = [];

  @override
  void initState() {
    super.initState();
    fetchWishlistedGameIDs().then((gameIDs) {
      setState(() {
        _gameIDs = gameIDs;
        _futureWishlistGames = fetchAllGamesDetails();
      });
    });
  }

  Future<List<String>> fetchWishlistedGameIDs() async {
    List<String> gameIDs = [];

    await wishlist.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    if (values != null) {
      values.forEach((key, values) {
        gameIDs.add(key.toString());
      });
      }
    });
    return gameIDs;
  }

  Future<List<GamesDetails>> fetchAllGamesDetails() async {
    List <int> lint = _gameIDs.map(int.parse).toList();
    final List<int> appids = lint;
    final List<GamesDetails> gamesDetails = await fetchInfos(appids);
    return gamesDetails;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    return FutureBuilder<List<GamesDetails>>(
      future: _futureWishlistGames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<GamesDetails> gamesDetails = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: gamesDetails.length,
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
                              left: 5, bottom: 5, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 5, left: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gameDetails.name,
                                    style: const TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 2, left: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gameDetails.publisher,
                                    style: const TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2, left: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gameDetails.price,
                                    style: const TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 90.0,
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
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Jeu(appid: gameDetails.id)),
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
                SizedBox(height: 10,),
                Center(
                    child: Text("Veuillez patienter", textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "GoogleSans",
                        fontSize: 20,
                      ),)),
              ]),
        );
      },
    );
  }

  Widget createWishlistView(BuildContext context, AsyncSnapshot snapshot) {
    return FutureBuilder<List<GamesDetails>>(
      future: _futureWishlistGames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<GamesDetails> gamesDetails = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: gamesDetails.length < 15 ? gamesDetails.length : 15,
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
                              left: 5, bottom: 5, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 5, left: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gameDetails.name,
                                    style: const TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 2, left: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gameDetails.publisher,
                                    style: const TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2, left: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    gameDetails.price,
                                    style: const TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 90.0,
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
                              style: TextStyle(
                                fontFamily: 'GoogleSans',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Jeu(appid: gameDetails.id)),
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
                SizedBox(height: 10,),
                Center(
                    child: Text("Veuillez patienter", textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "GoogleSans",
                        fontSize: 20,
                      ),)),
              ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          icon: SvgPicture.asset('assets/icons/close.svg'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Accueil()),
            );
          },
        ),
      ),
      body: Column(
        children: [
      _gameIDs.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            ),
          ],
        ),
      )
          :  Expanded(
        child: FutureBuilder<List<GamesDetails>>(
          future: _futureWishlistGames,
          builder: (context, snapshot) {
            return createListView(context, snapshot);
          },
        ),
      ),
    ]
      )
    );
  }
}
