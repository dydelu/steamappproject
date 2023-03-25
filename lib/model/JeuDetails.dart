import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<int>> fetchAllGames() async {
  final response = await http.get(Uri.parse(
      'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> ranks = jsonResponse['response']['ranks'];
    final List<int> appids = ranks.map((rank) => rank['appid'] as int).toList();
    // ignore: unnecessary_null_comparison
    if (ranks != null) {
      return appids;
    } else {
      throw Exception('No games found in response');
    }
  } else {
    throw Exception('Failed to load data');
  }
}

class GamesDetails {
  final int appid;
  final String name;
  final String price;
  final String publisher;
  final String headerImage;

  GamesDetails(
      {required this.appid,
      required this.name,
      required this.price,
      required this.publisher,
      required this.headerImage});
}

Future<List<GamesDetails>> fetchInfos(List<int> infoIds) async {
  final List<GamesDetails> jeux = [];

  for (int appid in infoIds) {
    final response = await http.get(Uri.parse(
        'https://store.steampowered.com/api/appdetails?appids=$appid'));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? jsonResponse =
          json.decode(response.body)[appid.toString()]['data'];
      if (jsonResponse != null) {
        final String name = jsonResponse['name'];
        final String headerImage = jsonResponse['header_image'];
        final String publisher = jsonResponse['publishers'];

        final Map<String, dynamic>? jsonResponse2 = json
            .decode(response.body)[appid.toString()]['data']['price_overview'];

        //On créé notre var Prix
        String price;
        //Si le jeu n'est pas gratuit (S'il est gratuit price_overview n'existe pas dans le code)
        if (jsonResponse2 != null) {
          //Si le prix du jeu est correctement renseigné
          if (jsonResponse2['initial_formatted'] != "") {
            //On récupère le prix initial (avant réduction)
            price = jsonResponse2['initial_formatted'];
          } else {
            //Sinon on récupère le prix final
            price = jsonResponse2['final_formatted'];
          }
        } else {
          //Sinon on le met gratuit
          price = "Gratuit";
        }

        //On envoie tout dans notre constructeur
        final GamesDetails jeu = GamesDetails(
            appid: appid,
            name: name,
            publisher: publisher,
            price: price,
            headerImage: headerImage);
        jeux.add(jeu);
      }
    } else {
      throw Exception('No games found in response');
    }
  }
  return jeux;
}

