import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TransactionDetails {
  String? avatar;
  String? name;
  String? date;
  String? amount;

  TransactionDetails({
    this.avatar,
    this.name,
    this.date,
    this.amount,
  });

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['name'] = name;
    data['date'] = date;
    data['amount'] = amount;
    return data;
  }
}

Future<List<TransactionDetails>> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://brotherlike-navies.000webhostapp.com/people/people.php'));

  if (response.statusCode == 200) {
    final List result = json.decode(response.body);
    return result.map((e) => TransactionDetails.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
