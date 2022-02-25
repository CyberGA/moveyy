import 'package:http/http.dart' as http;

const _apiKey = "77852d7723edac6732e1859e4bf1ed61";

class NetworkCall {
  final String movieType;

  final String _baseUrl = "https://api.themoviedb.org/3";
  final String imgUrl = "https://image.tmdb.org/t/p/original";

  String adventure = '/discover/movie?api_key=$_apiKey&language=en-US';
  String crime = '/discover/movie?api_key=$_apiKey&with_genres=80';
  String action = '/discover/movie?api_key=$_apiKey&with_genres=28';
  String anime = '/discover/movie?api_key=$_apiKey&with_genres=16&sort_by=popularity.desc';
  NetworkCall({
    required this.movieType,
  });

  Future getMovieRequest() async {
    final String target;
    print(movieType);

    switch (movieType.toLowerCase()) {
      case "adventure":
        target = adventure;
        break;
      case "action":
        target = action;
        break;
      case "crime":
        target = crime;
        break;
      case "anime":
        target = anime;
        break;
      default:
        target = action;
    }

    try {
      await http.get(Uri.parse('$_baseUrl$target')).then((http.Response response) {
        final data = response.body;
        
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future getImageRequest(String imgId) async {
    try {
      await http.get(Uri.parse('$imgUrl$imgId')).then((http.Response response) {
        final data = response.body;
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }
}
