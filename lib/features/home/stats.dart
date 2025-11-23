import 'package:flutter/material.dart';
import 'package:wander/features/home/continents.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Overview Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Travel Journey',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatOverview(
                          icon: Icons.public,
                          value: '47/195',
                          label: 'Countries',
                          percentage: 24.1,
                          color: const Color(0xFF2B7A9B),
                        ),
                        _StatOverview(
                          icon: Icons.map,
                          value: '5/7',
                          label: 'Continents',
                          percentage: 71.4,
                          color: const Color(0xFFE8956B),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Continents Section
            const Text(
              'Continents Explored',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const ContinentProgressList(),
            const SizedBox(height: 20),

            // Miles Tracked Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.flight,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Miles Traveled',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '45,273',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'That\'s 1.8x around the Earth! 🌍',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _MileStat(
                          icon: Icons.flight_takeoff,
                          value: '38,492',
                          label: 'By Air',
                        ),
                        _MileStat(
                          icon: Icons.directions_car,
                          value: '5,281',
                          label: 'By Car',
                        ),
                        _MileStat(
                          icon: Icons.train,
                          value: '1,500',
                          label: 'By Train',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Milestones Section
            const Text(
              'Milestones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _MilestoneCard(
              title: 'First International Trip',
              subtitle: 'Paris, France',
              date: 'June 2018',
              icon: Icons.celebration,
              color: const Color(0xFFE8956B),
            ),
            _MilestoneCard(
              title: '25th Country Visited',
              subtitle: 'Tokyo, Japan',
              date: 'March 2023',
              icon: Icons.military_tech,
              color: const Color(0xFF2B7A9B),
            ),
            _MilestoneCard(
              title: '100th City Explored',
              subtitle: 'Barcelona, Spain',
              date: 'September 2024',
              icon: Icons.emoji_events,
              color: const Color(0xFFFFD700),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatOverview extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final double percentage;
  final Color color;

  const _StatOverview({
    required this.icon,
    required this.value,
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _MileStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _MileStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final IconData icon;
  final Color color;

  const _MilestoneCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$subtitle • $date'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // View milestone details
        },
      ),
    );
  }
}