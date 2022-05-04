import 'package:flutter/material.dart';

Widget errorWidget() => const Center(
  child: Text(
    "An error occurred",
    style: TextStyle(fontSize: 20, decoration: TextDecoration.underline, fontStyle: FontStyle.italic),
  ),
);
