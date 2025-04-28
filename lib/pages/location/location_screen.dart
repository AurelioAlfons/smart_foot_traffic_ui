import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/components/appbar_state.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onHomePressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (route) => false); //
        },
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Welcome to the Location Screen!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
