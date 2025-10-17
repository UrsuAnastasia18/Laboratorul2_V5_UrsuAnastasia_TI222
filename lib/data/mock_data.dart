import '../models/doctor.dart';

//// Lista acțiunilor rapide (cardurile de sus din ecranul principal)
final List<Map<String, String>> quickActions = [
  {'title': 'Book Appointment', 'asset': 'assets/images/book.jpg'},
  {'title': 'Instant Video Consult', 'asset': 'assets/images/video.jpg'},
  {'title': 'Medicines', 'asset': 'assets/images/medicines.jpg'},
  {'title': 'Lab Tests', 'asset': 'assets/images/lab.jpg'},
  {'title': 'Emergency', 'asset': 'assets/images/emergency.png'},
];

// Lista medicilor afișați în aplicație
// Cei doi primi sunt General Practitioners (doar vizual), iar
// Dr. Emma Kathrin (Cardiologist) are o pagină detaliată.
final List<Doctor> mockDoctors = [
  Doctor(
    name: 'Dr. Mark Joseph',
    specialty: 'General Practitioner',
    rating: 4.5,
    yearsOfWork: 12,
    patients: 175,
    clinic: 'City Medical Center',
    location: 'Dhaka, Bangladesh',
    price: 850,
    assetImage: 'assets/images/general1.png',
  ),
  Doctor(
    name: 'Dr. Tanvir Ahassan',
    specialty: 'General Practitioner',
    rating: 4.6,
    yearsOfWork: 10,
    patients: 200,
    clinic: 'Green Life Hospital',
    location: 'Mirpur, Dhaka',
    price: 800,
    assetImage: 'assets/images/general2.png',
  ),
  Doctor(
    name: 'Dr. Emma Kathrin',
    specialty: 'Cardiologist',
    rating: 4.3,
    yearsOfWork: 14,
    patients: 125,
    clinic: 'Evercare Hospital Ltd.',
    location: 'Bashundhara, Dhaka',
    price: 1000,
    assetImage: 'assets/images/emma.jpg',
  )
];