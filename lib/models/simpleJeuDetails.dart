import 'dart:convert';
import 'package:http/http.dart' as http;

class SimpleJeuDetails {
  final String baseUrl = 'https://steamcommunity.com/actions/SearchApps/';

  Future<List<dynamic>> searchGames(String query) async {
    final response = await http.get(Uri.parse(baseUrl + query));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load games');
    }
  }
}
