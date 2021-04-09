import 'package:flutter/material.dart';
import 'Pages/Homepage.dart';
import 'Pages/RepositoryHomePage.dart';
import 'Pages/Gallery.dart';
import 'Pages/CounterPage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "/": (context) => HomePage(),
        "/repositories": (context) => RepositoryHomePage(),
        "/galerie": (context) => Gallery(),
        "/counter": (context) => CounterPage(),
      },
    );
  }
}
