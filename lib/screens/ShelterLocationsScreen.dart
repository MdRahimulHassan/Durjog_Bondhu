import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ShelterLocationsScreen extends StatefulWidget {
  const ShelterLocationsScreen({super.key});

  @override
  State<ShelterLocationsScreen> createState() => _ShelterLocationsScreenState();
}

class _ShelterLocationsScreenState extends State<ShelterLocationsScreen> {
  final List<Map<String, dynamic>> _shelterLocations = []; // List to store shelters
  bool _isAddingShelter = false; // Track whether the user is in add mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shelter Locations")),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(23.777176, 90.399452),
              initialZoom: 13.0,
              onTap: (tapPosition, point) {
                if (_isAddingShelter) {
                  _addShelter(point);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _shelterLocations.map((shelter) {
                  return Marker(
                    point: shelter['location'],
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => _showShelterDetails(shelter), // Show details popup
                      child: const Icon(Icons.location_pin, color: Colors.green, size: 50),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Floating button to enable shelter adding mode
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isAddingShelter = true; // Enable add mode
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tap on the map to add a shelter")),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _addShelter(LatLng point) {
    setState(() {
      _shelterLocations.add({
        'location': point,
        'name': 'Shelter ${_shelterLocations.length + 1}',
        'capacity': '50 people', // Example info
      });
      _isAddingShelter = false; // Disable add mode
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Shelter added successfully!")),
    );
  }

  void _showShelterDetails(Map<String, dynamic> shelter) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(shelter['name']),
        content: Text("Capacity: ${shelter['capacity']}\nLocation: ${shelter['location']}"),
        actions: [
          TextButton(
            onPressed: () {
              _removeShelter(shelter); // Call remove method
              Navigator.pop(context);
            },
            child: const Text("Remove Shelter", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _removeShelter(Map<String, dynamic> shelter) {
    setState(() {
      _shelterLocations.remove(shelter);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Shelter removed!")),
    );
  }
}
