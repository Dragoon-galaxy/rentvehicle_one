// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});

  @override
  _MyTripsPageState createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
      ),
      body: const Center(
        child: Text(
        'No Trips yet!',
        style: TextStyle(
          fontSize: 20, // Adjust the font size as needed
          fontWeight: FontWeight.bold, // Adjust the font weight as needed
        ),
      ),
      ),
    );
  }
}
