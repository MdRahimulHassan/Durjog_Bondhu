import 'package:flood_rescue_app/screens/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the generated options file
import 'splash_screen.dart'; // Import the splash screen file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use your options here
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flood Rescue App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(), // Use SplashScreen as the initial screen
    );
  }
}
