import 'package:flutter/material.dart';

// Bara de căutare folosită pe ecranul principal (HomeScreen)
class SearchBarApp extends StatelessWidget {
  const SearchBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Umbră discretă pentru efect de elevație
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),

      // Conținutul barei de căutare
      child: Row(
        children: const [
          Icon(Icons.search, color: Colors.grey), // pictograma de căutare
          SizedBox(width: 8),
          Expanded(
            // Câmpul de text unde utilizatorul scrie
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...', // text ajutător (placeholder)
                border: InputBorder.none, // fără chenar standard
              ),
            ),
          ),
          Icon(Icons.tune, color: Colors.grey), // pictogramă de filtrare
        ],
      ),
    );
  }
}