import 'package:flutter/material.dart';
import 'package:moveyy/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moveyy',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: const Color(0xff00e36a),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff00e36a))),
      home: const Home(),
    );
  }
}
