import 'package:flutter/material.dart';

// Card reutilizabil pentru acțiunile rapide (Book Appointment, Medicines etc.)
class CategoryCard extends StatelessWidget {
  final String title;       // textul afișat sub imagine
  final String assetImage;  // calea imaginii din folderul assets

  const CategoryCard({
    super.key,
    required this.title,
    required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // umbră subtilă
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Imaginea de sus din card
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              assetImage,
              fit: BoxFit.cover,
              height: 90,
              width: double.infinity,
            ),
          ),

          // Titlul sub imagine
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}