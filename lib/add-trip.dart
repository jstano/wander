import 'package:flutter/material.dart';

class AddTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Trip')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Trip Title')),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'Start Date')),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'End Date')),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'City (optional)')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/tripdetail'),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
