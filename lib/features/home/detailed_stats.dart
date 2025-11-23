import 'package:flutter/material.dart';

class DetailedStatsScreen extends StatelessWidget {
  const DetailedStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Statistics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            // World Coverage Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'World Coverage',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _CoverageItem(
                      label: 'Countries',
                      current: 47,
                      total: 195,
                      icon: Icons.public,
                    ),
                    const SizedBox(height: 12),
                    _CoverageItem(
                      label: 'Continents',
                      current: 5,
                      total: 7,
                      icon: Icons.map,
                    ),
                    const SizedBox(height: 12),
                    _CoverageItem(
                      label: 'UNESCO Sites',
                      current: 23,
                      total: 1157,
                      icon: Icons.account_balance,
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

class _CoverageItem extends StatelessWidget {
  final String label;
  final int current;
  final int total;
  final IconData icon;

  const _CoverageItem({
    required this.label,
    required this.current,
    required this.total,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (current / total * 100).toStringAsFixed(1);

    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$current/$total ($percentage%)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: current / total,
                  backgroundColor: Colors.grey[200],
                  minHeight: 6,
                ),
              ),
            ],
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