import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steamappproject/home.dart';
import 'package:steamappproject/jeu.dart';
import 'wishlist.dart';
import 'likes.dart';
import 'colors.dart';
import 'models/JeuDetails.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void useSearchBar(String query) {

  }

  Widget searchBar(){
    final _searchBar = TextEditingController();
    return Column(
      children: [
        Padding(
          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
          padding: const EdgeInsets.only(
              bottom: 10, top: 15, left: 30, right: 30),
          child: TextField(
            controller: _searchBar,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: c2,
                onPressed: () {},
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

  Widget createTopCard() {
    return Card(
      child: SizedBox(
        width: 400.0,
        height: 200.0,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/titanfall2.JPG', // Replace with your asset image path
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 55),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Titan Fall 2 \n Ultimate Edition',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 35),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Titanfall 2 est un jeu vidéo de tir en vue \n à la première personne',
                  style: TextStyle(
                    fontFamily: 'GoogleSans',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 145),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: c2,
                    elevation: 0,
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 40, right: 40),
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
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                width: 100,
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ps4-titanfall2.JPG'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    repeat: ImageRepeat.noRepeat,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    return FutureBuilder<List<GamesDetails>>(
      future: _futureGames,
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
                                MaterialPageRoute(builder: (context) => Jeu(appid: gameDetails.id)),
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
            },
          ),
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
      body: Column(
        children: [
          searchBar(),
          createTopCard(),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Les meilleures ventes",
                style: TextStyle(
                  fontFamily: 'GoogleSans',
                  fontSize: 15,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<GamesDetails>>(
              future: _futureGames,
              builder: (context, snapshot) {
                return createListView(context, snapshot);
              },
            ),
          ),
        ],
      ),
    );
  }
}
