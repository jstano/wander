import 'package:flutter/material.dart';

class MapSetupScreen extends StatelessWidget {
  const MapSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Visited Countries')),
      body: Center(child: Text('World Map Placeholder')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/home'),
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
