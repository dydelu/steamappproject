import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wishlist.dart';
import 'likes.dart';
import 'colors.dart';
import 'accueil.dart';
import 'models/JeuDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Recherche extends StatefulWidget {
  const Recherche({Key? key, required this.query}) : super(key: key);
  final String? query;

  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  late Future<List<GamesDetails>> _futureRechercheGames;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _search();
    _futureRechercheGames = fetchSearchGamesDetails();
  }

  Future<List<int>> _search() async {
    final response = await http.get(Uri.parse(
        'https://steamcommunity.com/actions/SearchApps/${widget.query}'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map<int>((game) => int.parse(game['appid'])).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }

  Future<List<GamesDetails>> fetchSearchGamesDetails() async {
    final List<int> appids = await _search();
    final List<GamesDetails> gamesDetails = await fetchInfos(appids);
    return gamesDetails;
  }

  Widget createListResults(BuildContext context, AsyncSnapshot snapshot) {
    return FutureBuilder<List<GamesDetails>>(
      future: _futureRechercheGames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<GamesDetails> resultsDetails = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: resultsDetails.length,
            itemBuilder: (context, index) {
              final GamesDetails gameDetails = resultsDetails[index];
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
                                    builder: (context) => Accueil()),
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
    );
  }

  Widget searchBar() {
    final _searchBar = TextEditingController();
    return Column(
      children: [
        Padding(
          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
          padding:
              const EdgeInsets.only(bottom: 10, top: 15, left: 30, right: 30),
          child: TextField(
            controller: _searchBar,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: c2,
                onPressed: () {
                  Navigator.push( context,
                  MaterialPageRoute(builder: (context) => Recherche(query: _searchBar.text)),);
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.blueGrey.shade900,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: c2,
                  width: 1.0,
                ),
              ),
              filled: true,
              fillColor: Colors.blueGrey.shade900,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(),
              hintText: "Rechercher un jeu...",
              hintStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: c1,
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/close.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Accueil()),
              );
            },
          ),
          centerTitle: false,
          title: const Text(
            'Recherche',
            style: TextStyle(fontFamily: 'GoogleSans'),
          ),
          titleSpacing: 15,
          backgroundColor: c1,
          automaticallyImplyLeading: false,
        ),
        body: Column(children: [
          searchBar(),
          Expanded(
            child: FutureBuilder<List<GamesDetails>>(
              future: _futureRechercheGames,
              builder: (context, snapshot) {
                return createListResults(context, snapshot);
              },
            ),
          ),
        ]));
  }
}
