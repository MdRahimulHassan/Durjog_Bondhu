import 'package:flutter/material.dart';

class AffectedZonesScreen extends StatelessWidget {
  const AffectedZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Affected & Safe Zones"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Image.asset(
          'assets/images/affectedvssafezone.png', // Your default map image path
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
