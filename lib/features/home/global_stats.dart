import 'package:flutter/material.dart';

class GlobalStatsCard extends StatelessWidget {
  const GlobalStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CompactStatItem(
              icon: Icons.public,
              count: '47',
              label: 'Countries',
              color: const Color(0xFF2B7A9B),
            ),
            _VerticalDivider(),
            _CompactStatItem(
              icon: Icons.map,
              count: '5',
              label: 'Continents',
              color: const Color(0xFFE8956B),
            ),
            _VerticalDivider(),
            _CompactStatItem(
              icon: Icons.location_city,
              count: '127',
              label: 'Cities',
              color: const Color(0xFF2B7A9B),
            ),
            _VerticalDivider(),
            _CompactStatItem(
              icon: Icons.flight,
              count: '45K',
              label: 'Miles',
              color: const Color(0xFFE8956B),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactStatItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;
  final Color color;

  const _CompactStatItem({
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(height: 4),
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
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

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey[300],
    );
  }
}
