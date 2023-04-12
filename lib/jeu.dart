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
  final likes = FirebaseDatabase.instance.ref().child("Likes");
  final wishlist = FirebaseDatabase.instance.ref().child("Wishlist");

  _JeuState();

  @override
  initState() {
    super.initState();
    _futureGame = getJeuDetails(widget.appid);
    getLiked(widget.appid, likes);
    getWishlisted(widget.appid, wishlist);
  }

  bool isPressed = true;
  bool isPressed2 = true;
  String? appId;

  void setDatabaseId(String id) {
    appId = id;
  }

  _pressed(final listeJeu, String? id) {
    setState(() {
      isPressed = !isPressed;
    });
    if (isPressed) {
      listeJeu.child(id.toString()).set({'wishlisted': true});
      print('added');
    } else {
      listeJeu.child(id.toString()).remove();
      print('supp');
    }
  }

  _pressed2(final listeJeu, String? id) {
    setState(() {
      isPressed2 = !isPressed2;
    });
    if (isPressed2) {
      listeJeu.child(id.toString()).set({'liked': true});
      print('added');
    } else {
      listeJeu.child(id.toString()).remove();
      print('supp');
    }
  }



  Future<void> getLiked(int id, final listeJeu) async {
    try {
      listeJeu.child(id.toString()).once().then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.exists) {
          setState(() {
            isPressed2 = true;
          });
        } else {
          setState(() {
            isPressed2 = false;
          });
        }
      }).catchError((error) {
        print("Error: $error");
      });
    } catch (error) {
      print("Erreur $error");
    }
  }

  Future<void> getWishlisted(int id,  final listeJeu) async {
    try {
      listeJeu.child(id.toString()).once().then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.exists) {
          setState(() {
            isPressed = true;

          });
        } else {
          setState(() {
            isPressed = false;

          });
        }
      }).catchError((error) {
        print("Error: $error");
      });
    } catch (error) {
      print("Erreur $error");
    }
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
                            Row(children: <Widget>[
                              const Padding(
                                padding:
                                    EdgeInsets.only(bottom: 5, left: 7),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Jean Denis",
                                    style: TextStyle(
                                      fontFamily: 'GoogleSans',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 130,),
                              Image.asset('assets/images/stars.png', height: 100,
                                  width: 100),
                            ]),
                            const Padding(
                              padding:
                                  EdgeInsets.only(bottom: 2, left: 7),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu, Sympa ce jeu,",
                                  style: TextStyle(
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
            setDatabaseId(gameDetails.appid.toString());
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
        });
  }

  Future<GamesDetails> getJeuDetails(int appid) async {
    final GamesDetails gameDetails = await fetchSingleInfos(appid);
    return gameDetails;
  }

  @override
  Widget build(BuildContext context) {
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
                    ? "assets/icons/like_full.svg"
                    : "assets/icons/like.svg",
                fit: BoxFit.fill,
              ),
              onPressed: () async {
                try {
                  _pressed2(likes, appId);
                } catch (e) {
                  print('error $e');
                }
              }),
          IconButton(
              icon: SvgPicture.asset(
                isPressed
                    ? "assets/icons/whishlist_full.svg"
                    : "assets/icons/whishlist.svg",
                fit: BoxFit.fill,
              ),
              onPressed: () async {
                try {
                  _pressed(wishlist, appId);
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
