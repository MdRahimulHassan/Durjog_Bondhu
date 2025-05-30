import 'package:flutter/material.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Forecast & Early Alert")),
      body: Center(
        child: Image.asset(
          'assets/images/weather_forecast.png',  // Replace with your actual image path
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
