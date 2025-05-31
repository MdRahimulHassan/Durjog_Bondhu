import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  @override
  void initState() {
    super.initState();
    _launchWeatherURL();
  }

  void _launchWeatherURL() async {
    final Uri url = Uri.parse('https://www.google.com/search?q=weather');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      // Optionally, you can close this screen after launching the URL:
      // Navigator.of(context).pop();
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show something simple while launching URL, or a loading indicator
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Forecast & Early Alert")),
      body: const Center(
        child: Text("Opening weather page..."),
      ),
    );
  }
}
