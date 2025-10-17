import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}
//pucntul de intrare a aplicatiei
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //widgetul principal al aplicatiei
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //elimina bannerul debug
      title: 'Laboratoare 2025', //titlu app
      theme: ThemeData(
        primarySwatch: Colors.teal,//culoare app
        scaffoldBackgroundColor: Colors.white,//fundal ecran
        fontFamily: 'Poppins',   //font folosit in toata app
      ),
      home: const HomeScreen(), //ecran principal
    );
  }
}