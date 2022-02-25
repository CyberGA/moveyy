import 'package:flutter/material.dart';
import 'package:moveyy/pages/movies.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.green, Color(0xff00e18c), Color(0xff00e36a)], stops: [0.2, 0.6, 0.9])),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.movie, color: Colors.black),
                SizedBox(width: 12),
                Text("Moveyy", style: TextStyle(color: Colors.black87)),
              ],
            ),
            centerTitle: true,
            elevation: 2,
          ),
          body: const Movies()),
    );
  }
}
