import 'package:flutter/material.dart';

// Summary box on the right side of the screen
class SummaryBoard extends StatelessWidget {
  const SummaryBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: const [
          Text('Heat Map Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          Text('Maximum - '),
          Text('Minimum - '),
          Text('Average - '),
          SizedBox(height: 16),
          Text('Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Longitude - '),
          Text('Latitude - '),
          Text('Area Name - '),
          SizedBox(height: 16),
          Text('Time'),
        ],
      ),
    );
  }
}
