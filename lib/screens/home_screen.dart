import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medicine_controller.dart';
import '../models/doctor.dart';
import 'doctor_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MedicineController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        // ui se actualizeaza automat cand controllerul schimba starea is loafing, error sau feed
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error.value != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Eroare: ${controller.error.value}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.loadFeed,
                    child: const Text('Reîncearcă'),
                  ),
                ],
              ),
            );
          }

          final feed = controller.feed;
          final user = feed['user'] as Map<String, dynamic>;
          final actions = (feed['actions'] as List).cast<Map<String, dynamic>>();
          final specialists = (feed['specialists'] as List).cast<Map<String, dynamic>>();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: user['profile_image'].toString().startsWith('http')
                          ? NetworkImage(user['profile_image'])
                          : AssetImage(user['profile_image']) as ImageProvider,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          user['location'],
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications_none, size: 26),
                  ],
                ),

                const SizedBox(height: 20),

                // SEARCH BAR
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.tune, color: Colors.grey),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // QUICK ACTIONS
                const Text(
                  'Quick Actions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(height: 10),

                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: actions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.78, // ajustare finală pentru a elimina overflow
                  ),
                  itemBuilder: (context, index) {
                    final item = actions[index];
                    return _ActionCard(title: item['title'], imageUrl: item['image']);
                  },
                ),

                const SizedBox(height: 28),

                // SPECIALISTS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Specialists',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      'View all >',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                SizedBox(
                  height: 230,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: specialists.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final doc = specialists[index];
                      return GestureDetector(
                        onTap: () {
                          final doctor = Doctor.fromJson(
                            controller.feed['doctorDetails']?['doctor'] ?? {},
                          );
                          Get.to(() => DoctorDetailsScreen(doctor: doctor));
                        },
                        child: _SpecialistCard(
                          name: doc['name'],
                          speciality: doc['speciality'],
                          rating: (doc['rating'] as num).toDouble(),
                          imageUrl: doc['image'],
                          available: doc['available'] as bool,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// CARD PENTRU ACȚIUNI RAPIDE
class _ActionCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  const _ActionCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: imageUrl.startsWith('http')
                  ? Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity)
                  : Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CARD PENTRU SPECIALIȘTI
class _SpecialistCard extends StatelessWidget {
  final String name;
  final String speciality;
  final double rating;
  final String imageUrl;
  final bool available;

  const _SpecialistCard({
    required this.name,
    required this.speciality,
    required this.rating,
    required this.imageUrl,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl.startsWith('http')
                ? Image.network(imageUrl, height: 120, width: 150, fit: BoxFit.cover)
                : Image.asset(imageUrl, height: 120, width: 150, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            speciality,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(rating.toStringAsFixed(1)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: available ? Colors.teal.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  available ? 'Available' : 'Unavailable',
                  style: TextStyle(
                    color: available ? Colors.teal : Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}