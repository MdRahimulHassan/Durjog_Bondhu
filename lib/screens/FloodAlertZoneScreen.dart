import 'package:flutter/material.dart';

class FloodAlertZonesScreen extends StatelessWidget {
  const FloodAlertZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flood Alert Zones"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/images/flood_alert_zone.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
