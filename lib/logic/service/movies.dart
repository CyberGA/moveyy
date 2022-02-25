import 'package:moveyy/logic/model/movie.dart';
import 'package:moveyy/logic/service/api_call.dart';

abstract class Movies {
  Future getMoviesData(String movieType);
}

class MoviesService implements Movies {
  @override
  Future getMoviesData(String movieType) async {
    final movieData = NetworkCall(movieType: movieType).getMovieRequest();
    return movieData;
  }
}
