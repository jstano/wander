import 'package:flutter/material.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trip Details')),
      body: Column(
        children: [
          Container(height: 200, color: Colors.grey[300], child: Center(child: Text('Cover Photo Placeholder'))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Trip Story / Notes here', style: TextStyle(fontSize: 16)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/aisummary'),
            child: Text('Generate AI Summary'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/paywall'),
            child: Text('Export PDF (Premium)'),
          ),
        ],
      ),
    );
  }
}
