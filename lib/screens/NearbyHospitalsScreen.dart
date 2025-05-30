import 'package:flutter/material.dart';

class NearbyHospitalsScreen extends StatelessWidget {
  const NearbyHospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Hospitals")),
      body: Center(
        child: Image.asset(
          'assets/images/nearby_hospitals_map.png', // Replace with your image path
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
