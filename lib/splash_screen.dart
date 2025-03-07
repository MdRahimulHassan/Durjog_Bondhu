import 'package:flood_rescue_app/screens/WelcomePage.dart'; // Import WelcomePage
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1), // Duration for the splash screen
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomePage()), // Navigate to WelcomePage
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to Flood Rescue App', // Your splash screen content
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
