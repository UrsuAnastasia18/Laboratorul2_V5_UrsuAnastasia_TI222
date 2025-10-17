import 'package:flutter/material.dart';

// Widget pentru afișarea unui interval orar (slot de programare)
class AppointmentSlot extends StatelessWidget {
  final String time;           // ora afișată (ex: "06:00 - 06:30")
  final bool selected;         // dacă slotul este selectat
  final VoidCallback? onTap;   // funcția apelată la apăsare

  const AppointmentSlot({
    super.key,
    required this.time,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Culoarea de fundal diferă în funcție de selecție
    final bg = selected ? const Color(0xFFD7ECEB) : const Color(0xFFEFF7F6);

    return InkWell(
      onTap: onTap, // permite apăsarea pe slot
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          time,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}