import 'package:flutter/material.dart';
import '../models/doctor.dart';

// Cardul individual pentru fiecare doctor (afișat în lista "Specialists")
class DoctorCard extends StatelessWidget {
  final Doctor doctor; // obiectul Doctor cu toate detaliile

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // umbră subtilă sub card
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),

      // Conținutul cardului
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),

          // Imaginea doctorului
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              doctor.assetImage, // imaginea din assets
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 10),

          // Specializarea doctorului
          Text(
            doctor.specialty,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}