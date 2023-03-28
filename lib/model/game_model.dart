class GamesDetails {
  int? appid;
  String? name;
  String? price;
  String? publisher;
  String? headerImage;

  GamesDetails(
      {required this.appid,
      required this.name,
      required this.price,
      required this.publisher,
      required this.headerImage});

  GamesDetails.fromJson(Map<String, dynamic> json) {
    appid = json['appid'];
    name = json['name'];
    price = json['final_formatted'];
    publisher = json['publishers'];
    headerImage = json['header_image'];
  }
}
