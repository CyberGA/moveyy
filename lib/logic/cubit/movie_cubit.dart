import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moveyy/logic/service/api_call.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(const MovieInitial());

  Future<void> getMovie(String movieType) async {
    try {
      emit(const MovieLoading());

      final movies = await NetworkCall(movieType: movieType).getMovieRequest();
      emit(MovieLoaded(movies));
    } on Exception {
      emit(const MovieError("Network anomaly. Check internet connection"));
    }
  }
}
