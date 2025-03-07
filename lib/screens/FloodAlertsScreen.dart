import 'package:flutter/material.dart';

class FloodAlertsScreen extends StatelessWidget {
  const FloodAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flood Alerts')),
      body: const Center(child: Text('Flood Alert Notifications')),
    );
  }
}
