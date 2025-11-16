import 'package:flutter/material.dart';

class PaywallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stano Pro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Unlock Premium Features', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(leading: Icon(Icons.auto_stories), title: Text('Unlimited AI Summaries')),
            ListTile(leading: Icon(Icons.picture_as_pdf), title: Text('High-quality PDF Export')),
            ListTile(leading: Icon(Icons.cloud), title: Text('Cloud Sync')),
            ListTile(leading: Icon(Icons.map), title: Text('Custom Map Themes')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text('Subscribe \$4.99 / month')),
            TextButton(onPressed: () {}, child: Text('Restore Purchase')),
          ],
        ),
      ),
    );
  }
}
