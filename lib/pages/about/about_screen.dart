import 'package:flutter/material.dart';
import 'package:smart_foot_traffic_ui/components/appbar_state.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
            'Welcome to the About Screen!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
