import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:moveyy/loading.dart';
import 'package:moveyy/logic/service/movies.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  final List<String> movieTypes = ["Action", "Adventure", "Crime", "Anime"];
  String? selectedMovie;

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
                    print(val);
                    setState(() {
                      selectedMovie = val;
                    });
                    await MoviesService().getMoviesData(val!).then((result) {
                      // ignore: avoid_print
                      print("show data" + result);
                      setState(() {
                        pageLoaded = true;
                      });
                    });
                  }),
            ),
          ),
        ),
        pageLoaded
            ? Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          tileColor: const Color(0xff00e18c).withOpacity(0.05),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Title",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Overview",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          leading: Image.network(
                            "https://source.unsplash.com/random/500x300",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Expanded(
                child: Center(
                  child: Text(
                    "Movie type not selecteed",
                    style: TextStyle(fontSize: 20, decoration: TextDecoration.underline, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
      ]),
    );
  }

  DropdownMenuItem<String> buildMenu(String item) => DropdownMenuItem(value: item, child: Center(child: Text(item)));
}
