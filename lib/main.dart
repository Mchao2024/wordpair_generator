import 'package:flutter/material.dart';
import 'package:wordpair_generator/utils/generateMaterialColor.dart';
import 'package:wordpair_generator/utils/customTheme.dart';
import 'package:wordpair_generator/random_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: generateMaterialColor(Palette.primaryColor),
        scaffoldBackgroundColor: Colors.black, // Set background color to black
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Set default text color to white
          headlineSmall: TextStyle(color: Colors.white), // AppBar title text color to white
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 8, 45, 212), // AppBar background color to black
          foregroundColor: Colors.white, // AppBar text/icon color to white
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Icon color to white
        ),
      ),
      home: RandomWords(),
    );
  }
}