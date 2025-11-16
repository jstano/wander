import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile / Settings')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 16),
          Text('User Name', style: TextStyle(fontSize: 20)),
          Text('user@example.com'),
          Divider(height: 32),
          ListTile(title: Text('Subscription Status'), trailing: Text('Free')),
          ListTile(title: Text('Export All Data')),
          ListTile(title: Text('Support / FAQ')),
          ListTile(title: Text('Logout')),
        ],
      ),
    );
  }
}
