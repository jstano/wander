import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Country Trips')),
      body: ListView(
        children: List.generate(3, (index) => ListTile(
          leading: Icon(Icons.photo),
          title: Text('Trip ${index + 1}'),
          subtitle: Text('Dates here'),
          onTap: () => Navigator.pushNamed(context, '/tripdetail'),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addtrip'),
        child: Icon(Icons.add),
      ),
    );
  }
}
