import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Dashboard')),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.blue[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Countries: 0'),
                Text('Continents: 0'),
                Text('Miles: 0'),
              ],
            ),
          ),
          Expanded(
            child: Center(child: Text('Interactive Map Placeholder')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addtrip'),
        child: Icon(Icons.add),
      ),
    );
  }
}
