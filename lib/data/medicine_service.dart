import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MedicineService {
  // Această metodă încarcă fișierul JSON din assets
  Future<Map<String, dynamic>> loadMedicineFeed() async {
    try {
      // citim fișierul JSON în mod asincron
      final rawData = await rootBundle.loadString('assets/data/medicine_feed.json');

      // decodăm textul JSON într-o structură Map
      final Map<String, dynamic> decodedData = json.decode(rawData);

      return decodedData;
    } catch (e) {
      // dacă apare o eroare (ex. fișierul lipsește), o aruncăm mai departe
      throw Exception('Eroare la încărcarea datelor: $e');
    }
  }
}