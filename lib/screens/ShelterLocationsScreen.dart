import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ShelterLocationsScreen extends StatefulWidget {
  const ShelterLocationsScreen({super.key});

  @override
  State<ShelterLocationsScreen> createState() => _ShelterLocationsScreenState();
}

class _ShelterLocationsScreenState extends State<ShelterLocationsScreen> {
  final List<Map<String, dynamic>> _shelterLocations = [];
  bool _isAddingShelter = false;

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
                  _showAddShelterDialog(point);
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
                      onTap: () => _showShelterDetails(shelter),
                      child: const Icon(Icons.location_pin, color: Colors.green, size: 50),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isAddingShelter = true;
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

  void _showAddShelterDialog(LatLng point) {
    final nameController = TextEditingController();
    final capacityController = TextEditingController();
    final freeSpaceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Shelter"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Shelter Name"),
              ),
              TextField(
                controller: capacityController,
                decoration: const InputDecoration(labelText: "Capacity"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: freeSpaceController,
                decoration: const InputDecoration(labelText: "Free Space"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isAddingShelter = false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  capacityController.text.isNotEmpty &&
                  freeSpaceController.text.isNotEmpty) {
                _addShelter(point, nameController.text, capacityController.text, freeSpaceController.text);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill in all fields")),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _addShelter(LatLng point, String name, String capacity, String freeSpace) {
    setState(() {
      _shelterLocations.add({
        'location': point,
        'name': name,
        'capacity': capacity,
        'freeSpace': freeSpace,
      });
      _isAddingShelter = false;
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
        content: Text(
          "Capacity: ${shelter['capacity']}\n"
              "Free Space: ${shelter['freeSpace']}\n"
              "Location: ${shelter['location']}",
        ),
        actions: [
          TextButton(
            onPressed: () {
              _removeShelter(shelter);
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
