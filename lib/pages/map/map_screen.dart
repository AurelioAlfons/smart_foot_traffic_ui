import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/components/appbar_state.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onHomePressed: () {},
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Welcome to the Map Screen!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
