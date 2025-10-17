import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../widgets/appointment_slot.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  int selectedSlot = -1;

  @override
  Widget build(BuildContext context) {
    final d = widget.doctor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          d.specialty,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.star_border, color: Colors.black87),
          SizedBox(width: 12),
          Icon(Icons.share_outlined, color: Colors.black87),
          SizedBox(width: 10),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _doctorHeader(d),
              const SizedBox(height: 14),
              _doctorStats(d),
              const SizedBox(height: 14),
              _tabBar(),
              const SizedBox(height: 16),
              _inClinicCard(d),
              const SizedBox(height: 25),
              _timing(),
              const SizedBox(height: 25),
              _locations(d),
            ],
          ),
        ),
      ),
    );
  }

  // ——— Secțiunea de sus: imagine + date doctor
  Widget _doctorHeader(Doctor d) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            d.assetImage,
            height: 90,
            width: 90,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(d.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800)),
              Text(d.specialty,
                  style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
              const Text('MBBS',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }

  // ——— Rating, experiență, pacienți
  Widget _doctorStats(Doctor d) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem(Icons.star, '${d.rating}', 'Rating & Review', const Color(0xFFFFC107)),
        _statItem(Icons.work_outline, '${d.yearsOfWork}', 'Years of work', Colors.teal),
        _statItem(Icons.groups_2_outlined, '${d.patients}', 'No. of patients', Colors.teal),
      ],
    );
  }

  Widget _statItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  // ——— Bara de taburi (Info / History / Review)
  Widget _tabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE3E6EA)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: const TabBar(
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        tabs: [
          Tab(text: 'Info'),
          Tab(text: 'History'),
          Tab(text: 'Review'),
        ],
      ),
    );
  }

  // ——— Secțiunea cu programarea în clinică
  Widget _inClinicCard(Doctor d) {
    final times = ['06:00 - 06:30', '06:30 - 07:00', '07:00 - 07:30', '07:30 - 08:00'];

    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E6EA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titlu + preț
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFE1F3F3),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Text('In-Clinic Appointment',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const Spacer(),
                Text('৳${d.price.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              ],
            ),
          ),

          // Detalii clinică
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Evercare Hospital Ltd.',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 3),
                Row(
                  children: const [
                    Text('Boshundhora, Dhaka',
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Spacer(),
                    Text('2 More clinic',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 6),
                const Text('20 mins or less wait time',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE0E3E7)),
                const SizedBox(height: 6),

                // Zile disponibile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Today (No Slot)',
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text('Tomorrow (20 Slot)',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                    Text('17 Oct (18 Slot)',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 14),

                // Orele de programare → pe o singură linie scrollabilă
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(times.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: AppointmentSlot(
                          time: times[i],
                          selected: selectedSlot == i,
                          onTap: () => setState(() => selectedSlot = i),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ——— Programul doctorului
  Widget _timing() {
    Widget pill(String day, String hours) {
      return Container(
        width: 160,
        height: 90, // ajustat pentru a elimina overflow-ul
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 6),
            Text(hours, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Timing',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              pill('Monday', '09:00 AM - 05:00 PM'),
              const SizedBox(width: 12),
              pill('Tuesday', 'Closed'),
              const SizedBox(width: 12),
              pill('Wednesday', '09:00 AM - 05:00 PM'),
            ],
          ),
        ),
      ],
    );
  }

  // ——— Locațiile clinicilor (toate uniforme)
  Widget _locations(Doctor d) {
    Widget chip(String title, String subtitle) {
      return Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 14)),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Location',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              chip('Shahbag', 'BSSMU - Bangabandhu'),
              const SizedBox(width: 12),
              chip('Bashundhora', 'Evercare Hospital Ltd.'),
              const SizedBox(width: 12),
              chip('Banani', 'Evercare Hospital Ltd.'),
            ],
          ),
        ),
      ],
    );
  }
}