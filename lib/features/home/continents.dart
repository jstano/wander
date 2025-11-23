import 'package:flutter/material.dart';

class ContinentProgressList extends StatelessWidget {
  const ContinentProgressList({super.key});

  @override
  Widget build(BuildContext context) {
    final continents = [
      ContinentData(
        name: 'Europe',
        icon: '🇪🇺',
        visited: 23,
        total: 44,
        color: const Color(0xFF2B7A9B),
      ),
      ContinentData(
        name: 'Asia',
        icon: '🌏',
        visited: 12,
        total: 48,
        color: const Color(0xFFE8956B),
      ),
      ContinentData(
        name: 'North America',
        icon: '🌎',
        visited: 8,
        total: 23,
        color: const Color(0xFF52B788),
      ),
      ContinentData(
        name: 'South America',
        icon: '🌎',
        visited: 3,
        total: 12,
        color: const Color(0xFFD62828),
      ),
      ContinentData(
        name: 'Africa',
        icon: '🌍',
        visited: 1,
        total: 54,
        color: const Color(0xFFF77F00),
      ),
      ContinentData(
        name: 'Oceania',
        icon: '🏝️',
        visited: 0,
        total: 14,
        color: const Color(0xFF9D4EDD),
      ),
      ContinentData(
        name: 'Antarctica',
        icon: '🧊',
        visited: 0,
        total: 1,
        color: const Color(0xFF4CC9F0),
      ),
    ];

    return Column(
      children: continents
          .map((continent) => ContinentProgressItem(data: continent))
          .toList(),
    );
  }
}

class ContinentData {
  final String name;
  final String icon;
  final int visited;
  final int total;
  final Color color;

  ContinentData({
    required this.name,
    required this.icon,
    required this.visited,
    required this.total,
    required this.color,
  });

  double get percentage => (visited / total) * 100;
}

class ContinentProgressItem extends StatelessWidget {
  final ContinentData data;

  const ContinentProgressItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // Navigate to continent detail view
        },
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${data.visited}/${data.total}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: data.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: data.visited / data.total,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(data.color),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}