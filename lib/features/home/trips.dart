import 'package:flutter/material.dart';

class TripsView extends StatelessWidget {
  const TripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Travel Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // Sort by date, location, etc.
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Replace with actual trips
        itemBuilder: (context, index) {
          return TripBookCard(
            title: 'Summer in Europe 2024',
            coverImage: 'assets/images/trip-cover.jpg',
            countries: 5,
            cities: 12,
            days: 21,
            photoCount: 247,
            onTap: () {
              // Navigate to trip detail
            },
          );
        },
      ),
    );
  }
}

class TripBookCard extends StatelessWidget {
  final String title;
  final String coverImage;
  final int countries;
  final int cities;
  final int days;
  final int photoCount;
  final VoidCallback onTap;

  const TripBookCard({
    super.key,
    required this.title,
    required this.coverImage,
    required this.countries,
    required this.cities,
    required this.days,
    required this.photoCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image with gradient overlay
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  // Use Image.asset or Image.network for actual image
                  child: const Icon(Icons.photo, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TripStat(
                    icon: Icons.public,
                    value: '$countries',
                    label: 'Countries',
                  ),
                  _TripStat(
                    icon: Icons.location_city,
                    value: '$cities',
                    label: 'Cities',
                  ),
                  _TripStat(
                    icon: Icons.calendar_today,
                    value: '$days',
                    label: 'Days',
                  ),
                  _TripStat(
                    icon: Icons.photo_library,
                    value: '$photoCount',
                    label: 'Photos',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TripStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _TripStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}