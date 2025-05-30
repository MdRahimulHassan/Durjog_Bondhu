import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class RescueRequestsMapScreen extends StatefulWidget {
  const RescueRequestsMapScreen({super.key});

  @override
  State<RescueRequestsMapScreen> createState() => _RescueRequestScreenState();
}

class _RescueRequestScreenState extends State<RescueRequestsMapScreen> {
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to get location")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Rescue')),
      body: _userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          initialCenter: _userLocation!,
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _userLocation!,
                width: 40,
                height: 40,
                child: const Icon(Icons.location_pin, color: Colors.red, size: 50),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _userLocation != null
          ? FloatingActionButton.extended(
        onPressed: () {
          // Here you can send rescue request logic
          print('Rescue request sent from: $_userLocation');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Rescue request sent")),
          );
        },
        label: const Text("Send Rescue Request"),
        icon: const Icon(Icons.send),
      )
          : null,
    );
  }
}
