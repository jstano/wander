import 'package:flutter/material.dart';
import 'package:wander/features/home/global_stats.dart';
import 'package:wander/features/home/map_view_openstreet.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WanderBooks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search locations
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GlobalStatsCard(),

            // Map takes most of the space
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              color: Colors.grey[200],
              child: MapViewOpenStreet(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
