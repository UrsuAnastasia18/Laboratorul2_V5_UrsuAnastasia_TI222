// Clasa care modelează informațiile despre un doctor
class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int yearsOfWork;
  final int patients;
  final String clinic;
  final String location;
  final double price;
  final String assetImage;

  //constructorul clasei doctor
  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.yearsOfWork,
    required this.patients,
    required this.clinic,
    required this.location,
    required this.price,
    required this.assetImage,
  });
}