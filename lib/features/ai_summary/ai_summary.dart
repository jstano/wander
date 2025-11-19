import 'package:flutter/material.dart';

class AiSummaryScreen extends StatelessWidget {
  const AiSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Short Summary', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('AI-generated short summary placeholder'),
            SizedBox(height: 16),
            Text('Medium Summary', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('AI-generated medium summary placeholder'),
            SizedBox(height: 16),
            Text('Long Summary', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('AI-generated long summary placeholder'),
          ],
        ),
      ),
    );
  }
}
