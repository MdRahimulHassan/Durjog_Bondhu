import 'package:flutter/material.dart';

class LiveRescueHeatmapScreen extends StatelessWidget {
  const LiveRescueHeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Rescue Heatmap'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/heatmap.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
