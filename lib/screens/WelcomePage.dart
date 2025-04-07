import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage("assets/images/WelcomeScreenBg.jpg"), // Fixed
            fit: BoxFit.fill, // Ensures image covers the screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 0),
            const Text(
              "WELCOME TO",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const Text(
              "FLOOD RESCUE APP",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
              child: const Text("LOGIN"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Change this to your desired color
                foregroundColor: Colors.white, // Text color,
            ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              ),
              child: const Text("SIGNUP"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Change this to your desired color
                foregroundColor: Colors.white, // Text color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
