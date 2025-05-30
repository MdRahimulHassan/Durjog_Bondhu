import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<Map<String, dynamic>> _shelterLocations = [];
  LatLng? _rescueRequestLocation;
  LatLng? _rescuerLocation;
  bool _isAddingShelter = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // for rescuer's location
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _rescuerLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _sendRescueRequest() async {
    await _getCurrentLocation();
    if (_rescuerLocation != null) {
      setState(() {
        _rescueRequestLocation = _rescuerLocation;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rescue request sent!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rescue & Shelter Map")),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(23.777176, 90.399452),
              initialZoom: 13.0,
              onTap: (tapPosition, point) {
                if (_isAddingShelter) {
                  _isAddingShelter = false;
                  _promptNewShelterDetails(point);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  // Shelter Markers
                  ..._shelterLocations.map((shelter) => Marker(
                    point: shelter['location'],
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => _editShelterDialog(shelter),
                      child: const Icon(Icons.location_pin, color: Colors.green, size: 50),
                    ),
                  )),
                  // Rescue Request Marker
                  if (_rescueRequestLocation != null)
                    Marker(
                      point: _rescueRequestLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.warning, color: Colors.red, size: 50),
                    ),
                  // Rescuer Marker
                  if (_rescuerLocation != null)
                    Marker(
                      point: _rescuerLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 50),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isAddingShelter = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tap on map to add a shelter")),
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _sendRescueRequest,
              backgroundColor: Colors.red,
              child: const Icon(Icons.sos),
            ),
          ),
        ],
      ),
    );
  }

  void _promptNewShelterDetails(LatLng point) {
    final nameController = TextEditingController();
    final capacityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Shelter Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: capacityController, decoration: const InputDecoration(labelText: "Capacity"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && capacityController.text.isNotEmpty) {
                setState(() {
                  _shelterLocations.add({
                    'name': nameController.text,
                    'capacity': capacityController.text,
                    'location': point,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _editShelterDialog(Map<String, dynamic> shelter) {
    final nameController = TextEditingController(text: shelter['name']);
    final capacityController = TextEditingController(text: shelter['capacity']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Shelter"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: capacityController, decoration: const InputDecoration(labelText: "Capacity"), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                _shelterLocations.remove(shelter);
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text("Remove", style: TextStyle(color: Colors.red))),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              shelter['name'] = nameController.text;
              shelter['capacity'] = capacityController.text;
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
