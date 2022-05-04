import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkCall {
  final String movieType;

  final String imgUrl = "https://image.tmdb.org/t/p/original";

  String adventure = 'https://62183f7c1a1ba20cba9c2507.mockapi.io/api/v1/AdventureMovies';
  String action = 'https://62183f7c1a1ba20cba9c2507.mockapi.io/api/v1/ActionMovie';
  String anime = 'https://62183f7c1a1ba20cba9c2507.mockapi.io/api/v1/AnimeMovie';
  NetworkCall({
    required this.movieType,
  });

  Future getMovieRequest() async {
    final String url;

    switch (movieType.toLowerCase()) {
      case "adventure":
        url = adventure;
        break;
      case "action":
        url = action;
        break;
      case "anime":
        url = anime;
        break;
      default:
        url = action;
    }

    try {
      final data = await http.get(Uri.parse(url)).then((http.Response response) => json.decode(response.body));

      return data["results"];
    } catch (e) {
      rethrow;
    }
  }
}
