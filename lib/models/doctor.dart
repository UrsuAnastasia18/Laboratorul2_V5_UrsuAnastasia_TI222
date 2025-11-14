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

  //  metoda de conversie din JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'] ?? '',
      specialty: json['speciality'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      yearsOfWork: json['years_of_experience'] ?? 0,
      patients: json['patients_treated'] ?? 0,
      clinic: json['clinic'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      assetImage: json['profile_image'] ?? json['assetImage'] ?? '',
    );
  }
}