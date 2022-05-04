part of 'movie_cubit.dart';

@immutable
abstract class MovieState {
  const MovieState();
}

class MovieInitial extends MovieState {
  const MovieInitial();
}

class MovieLoading extends MovieState {
  const MovieLoading();
}

class MovieLoaded extends MovieState {
  final List movies;
  const MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
