import 'package:flutter/material.dart';

// Mic widget folosit pentru afișarea unei specialități (cu emoji + text)
class SpecialityChip extends StatelessWidget {
  final String iconEmoji; // emoji-ul sau simbolul afișat (ex: 🦷, ❤️)
  final String label;     // textul descriptiv al specialității

  const SpecialityChip({
    super.key,
    required this.iconEmoji,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cercul colorat cu emoji în centru
        Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
            color: const Color(0xFFE6F3F3),
            borderRadius: BorderRadius.circular(64),
          ),
          child: Center(
            child: Text(
              iconEmoji,
              style: const TextStyle(fontSize: 26),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Eticheta specialității (sub emoji)
        SizedBox(
          width: 92,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}