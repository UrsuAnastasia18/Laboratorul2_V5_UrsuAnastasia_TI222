import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/medicine_controller.dart';
import 'screens/home_screen.dart';

void main() {
  // înregistrăm controllerul GetX înainte de pornirea aplicației
  Get.put(MedicineController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratoare 2025',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(), // ecranul principal al aplicației
    );
  }
}