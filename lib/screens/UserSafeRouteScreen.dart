import 'package:flutter/material.dart';

class UserSafeRouteScreen extends StatelessWidget {
  const UserSafeRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User's Safe Route")),
      body: Center(
        child: Image.asset(
          'assets/images/user_safe_route.png', // Replace with your actual image path
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
