import 'package:flutter/material.dart';

class RescueRequestScreen extends StatelessWidget {
  const RescueRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Rescue')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print('Rescue request sent');
          },
          child: const Text('Send Rescue Request'),
        ),
      ),
    );
  }
}