import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'wishlist.dart';
import 'likes.dart';
import 'colors.dart';
import 'model/JeuDetails.dart';

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        centerTitle: false,
        title:
            const Text('Accueil', style: TextStyle(fontFamily: 'GoogleSans')),
        backgroundColor: c1,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
                '/Users/julesm/github/steamappproject/assets/icons/like.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Likes()),
              );
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
                '/Users/julesm/github/steamappproject/assets/icons/whishlist.svg'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Les meilleures ventes",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  decoration: TextDecoration.underline),
            ),
          ),
          Center(
            child: FutureBuilder<List<GamesDetails>>(
              future: fetchInfos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                              snapshot.data![index].appid.toString()),
                        ),
                        title: Text(
                          snapshot.data![index].appid.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Text(snapshot.data![index].appid.toString(),
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(snapshot.data![index].appid.toString(),
                            style: const TextStyle(color: Colors.white)),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
