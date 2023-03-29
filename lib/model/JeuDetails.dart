import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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


int get id{
  return appid;
}

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
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Map<String, dynamic>? data1 = jsonResponse['$appid']?['data'];
      final Map<String, dynamic>? data2 = jsonResponse['1']?['data'];
      final Map<String, dynamic>? gameData = data1 ?? data2;

      if (gameData != null) {
        final String name = gameData['name'];
        final String headerImage = gameData['header_image'];
        final List<dynamic> publishers = gameData['publishers'];
        final String publisher = publishers.join(', ');

        final bool? jsonGameFree = gameData['is_free'];
        final Map<String, dynamic>? jsonGamePrice = gameData['price_overview'];
        String price;

        if (jsonGameFree == true) {
          price = "Gratuit";
        } else {
          price = jsonGamePrice?['final_formatted'] ?? "";
        }

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
