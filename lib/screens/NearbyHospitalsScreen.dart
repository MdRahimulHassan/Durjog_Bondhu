import 'package:flutter/material.dart';

class NearbyHospitalsScreen extends StatelessWidget {
  const NearbyHospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Hospitals'),
        backgroundColor: Colors.deepPurple, // Optional: to match the heatmap screen
      ),
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/hospital.png', // Ensure this image is in pubspec.yaml
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
