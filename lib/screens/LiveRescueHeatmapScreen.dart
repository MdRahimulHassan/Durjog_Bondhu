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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/live_heatmap.png', // Replace with your actual image path
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'This is a placeholder for the Live Rescue Heatmap.\nYou can integrate a real-time map view here later.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
