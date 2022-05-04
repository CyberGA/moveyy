import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveyy/error.dart';
import 'package:moveyy/initial.dart';
import 'package:moveyy/loading.dart';
import 'package:moveyy/logic/cubit/movie_cubit.dart';
import 'package:moveyy/logic/service/api_call.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  final List<String> movieTypes = ["Action", "Adventure", "Anime"];
  String? selectedMovie;

  late List currentMovies;

  bool pageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(children: <Widget>[
        Container(
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration:
                BoxDecoration(color: const Color(0xff00e18c).withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                  items: movieTypes.map(buildMenu).toList(),
                  hint: const Text(
                    "Select movie type",
                  ),
                  buttonElevation: 1,
                  value: selectedMovie,
                  alignment: Alignment.center,
                  isExpanded: true,
                  dropdownElevation: 1,
                  dropdownPadding: const EdgeInsets.symmetric(horizontal: 20),
                  buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
                  dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  onChanged: (val) async {
                    setState(() {
                      selectedMovie = val;
                    });

                    final movies = await NetworkCall(movieType: selectedMovie.toString()).getMovieRequest();

                    setState(() {
                      currentMovies = movies;
                      pageLoaded = true;
                    });
                  }),
            ),
          ),
        ),
        Expanded(child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieInitial) {
              return initialWIdget();
            } else if (state is MovieLoaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        tileColor: const Color(0xff00e18c).withOpacity(0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (state.movies[index]["original_title"] ?? state.movies[index]["title"].toString()),
                              textAlign: TextAlign.left,
                              style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              shorten(word: state.movies[index]["overview"]),
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        // leading: Image.network(
                        //   "https://image.tmdb.org/t/p/original${currentMovies[index]["backdrop_path"]}",
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is MovieLoading) {
              return loadingWidget();
            } else {
              return errorWidget();
            }
          },
        ))
      ]),
    );
  }

  DropdownMenuItem<String> buildMenu(String item) => DropdownMenuItem(value: item, child: Center(child: Text(item)));

  shorten({required String word, int n = 200}) {
    return word.length > n ? word.substring(0, n - 1) + " . . . . " : word;
  }
}
