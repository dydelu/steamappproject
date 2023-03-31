import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steamappproject/accueil.dart';
import 'home.dart';
import 'colors.dart';
import 'models/JeuDetails.dart';
import 'likes.dart';

class Jeu extends StatefulWidget {
  const Jeu({Key? key, required this.appid}) : super(key: key);

  final int appid;

  @override
  _JeuState createState() => _JeuState();
}

class _JeuState extends State<Jeu> {
  late Future<GamesDetails> _futureGame;
  final database = FirebaseDatabase.instance.ref();

  _JeuState();

  initState() {
    _futureGame = fetchGamesDetails(widget.appid);
    super.initState();
  }

  // Defining a variable for storing click state
  bool isPressed = false;
  bool isPressed2 = false;

  // Click function for changing the state on click
  _pressed(final listeJeu) {
    var newVal = true;
    if (isPressed) {
      newVal = false;
      listeJeu.child('Likes').push().set({'nom': 'JeuBlabla', 'price': 5});
    } else {
      newVal = true;
    }
    // This function is required for changing the state.
    // Whenever this function is called it refresh the page with new value
    setState(() {
      isPressed = newVal;
    });
  }

  _pressed2(final listeJeu) {
    var newVal2 = true;
    if (isPressed2) {
      newVal2 = false;
      listeJeu
          .child('Wishlist')
          .push()
          .set({'nom': 'JeuBlabla', 'price': 5000});
    } else {
      newVal2 = true;
    }
    setState(() {
      isPressed2 = newVal2;
    });
  }

  Widget _tabSection(BuildContext context, GamesDetails gameDetails) {
    return DefaultTabController(
      length: 2,
      child: Column(children: <Widget>[
        Container(
          child: TabBar(
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              labelColor: c2,
              unselectedLabelColor: c2,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(color: c2),
              tabs: [
                Tab(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: c2, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Description",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: c2, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Avis",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        Container(
          constraints: const BoxConstraints(
            maxHeight: 1500,
          ),
          child: TabBarView(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                gameDetails.description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
                child: Card(
              margin: const EdgeInsets.all(5),
              color: c3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 350.0,
                        padding:
                            const EdgeInsets.only(left: 5, bottom: 5, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, left: 7),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Jean Denis",
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
                                 "Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu,",
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
                    ],
                  ),
                ],
              ),
            ))
          ]),
        ),
      ]),
    );
  }

  Widget createDetails(BuildContext context, AsyncSnapshot snapshot) {
    return FutureBuilder<GamesDetails>(
        future: _futureGame,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final GamesDetails gameDetails = snapshot.data!;
            return Column(children: [
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .30,
                        child: Image.network(gameDetails.headerImage),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .55,
                        color: c1,
                      )
                    ],
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .20,
                          right: 20.0,
                          left: 20.0),
                      child: Card(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 7),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            gameDetails.name.toString(),
                                            style: const TextStyle(
                                              fontFamily: 'GoogleSans',
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 2, left: 7),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            gameDetails.publisher.toString(),
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
                              ],
                            ),
                          ],
                        ),
                      )),
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .4,
                          right: 10.0,
                          left: 10.0),
                      child: _tabSection(context, gameDetails)),
                ],
              )
            ]);
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
        });
  }

  Future<GamesDetails> fetchGamesDetails(int appid) async {
    final GamesDetails gameDetails = await fetchSingleInfos(appid);
    return gameDetails;
  }

  @override
  Widget build(BuildContext context) {
    final listeJeu = database.child("Profil/");

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
          icon: SvgPicture.asset('assets/icons/back.svg'),
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
                isPressed2
                    ? "assets/icons/like.svg"
                    : "assets/icons/like_full.svg",
                fit: BoxFit.fill,
              ),
              onPressed: () async {
                try {
                  _pressed2(listeJeu);
                  print('ajoute');
                } catch (e) {
                  print('error $e');
                }
              }),
          IconButton(
              icon: SvgPicture.asset(
                isPressed
                    ? "assets/icons/whishlist.svg"
                    : "assets/icons/whishlist_full.svg",
                fit: BoxFit.fill,
              ),
              onPressed: () async {
                try {
                  _pressed(listeJeu);
                  print('ajoute');
                } catch (e) {
                  print('error $e');
                }
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              margin:
                  const EdgeInsets.only(bottom: 0, top: 0, left: 30, right: 30),
            ),
            Expanded(
                child: ListView(shrinkWrap: true, children: [
              FutureBuilder<GamesDetails>(
                  future: _futureGame,
                  builder: (context, snapshot) {
                    return createDetails(context, snapshot);
                  }),
            ]))
          ],
        ),
      ),
    );
  }
}
