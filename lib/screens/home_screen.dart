import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/category_card.dart';
import '../widgets/doctor_card.dart';
import '../widgets/search_bar_app.dart';
import 'doctor_details_screen.dart';

// Ecranul principal al aplicației (Home)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ——— HEADER: avatar, nume, locație, notificare
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/user.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Tanvir Ahassan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Mirpur, Dhaka',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none, size: 26),
                ],
              ),

              const SizedBox(height: 20),

              // ——— Bara de căutare
              const SearchBarApp(),
              const SizedBox(height: 20),

              // ——— QUICK ACTIONS (2 sus + 3 jos)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(quickActions.length, (index) {
                  double width;

                  // 2 carduri pe primul rând
                  if (index < 2) {
                    width = MediaQuery.of(context).size.width / 2 - 22;
                  } else {
                    // 3 carduri pe următorul rând
                    width = MediaQuery.of(context).size.width / 3 - 20;
                  }

                  return SizedBox(
                    width: width,
                    child: CategoryCard(
                      key: ValueKey(index),
                      title: quickActions[index]['title']!,
                      assetImage: quickActions[index]['asset']!,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 25),

              // ——— Secțiunea: Specialities
              const Text(
                'Specialities most relevant to you',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),

              // Lista orizontală cu specialități
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const _SpecialityIcon('Eye Specialist', Icons.remove_red_eye_outlined),
                    const _SpecialityIcon('Dentist', Icons.medical_services_outlined),

                    // 🔹 Când se apasă Cardiologist → deschide profilul Emmei
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DoctorDetailsScreen(
                              doctor: mockDoctors.firstWhere(
                                    (doc) => doc.specialty == 'Cardiologist',
                              ),
                            ),
                          ),
                        );
                      },
                      child: const _SpecialityIcon('Cardiologist', Icons.favorite_border),
                    ),

                    const _SpecialityIcon('Pulmonologist', Icons.air),
                    const _SpecialityIcon('Physician', Icons.person_outline),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ——— Secțiunea: Specialists (lista de doctori)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Specialists',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'View all >',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Listă orizontală cu doctori (General Practitioners)
              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: mockDoctors.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return DoctorCard(doctor: mockDoctors[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ——— Componentă mică pentru fiecare specialitate (pictogramă + etichetă)
class _SpecialityIcon extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SpecialityIcon(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFE0F4F2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: Colors.teal),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}