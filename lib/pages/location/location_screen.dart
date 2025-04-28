import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Location Screen!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
