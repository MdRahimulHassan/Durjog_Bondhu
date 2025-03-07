import 'package:flutter/material.dart';

class ShelterLocationsScreen extends StatefulWidget {
  @override
  _ShelterLocationsScreenState createState() => _ShelterLocationsScreenState();
}

class _ShelterLocationsScreenState extends State<ShelterLocationsScreen> {
  List<Map<String, String>> shelters = [
    {"name": "Community Shelter 1", "address": "IICT SUST", "distance": "1.5 km"},
    {"name": "Relief Camp 2", "address": "Border Gard School & College", "distance": "3.0 km"},
    {"name": "Emergency Shelter 3", "address": "MC College", "distance": "7.8 km"},
  ];

  void _addShelter() {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController distanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Shelter Location"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Shelter Name"),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              TextField(
                controller: distanceController,
                decoration: const InputDecoration(labelText: "Distance"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    addressController.text.isNotEmpty &&
                    distanceController.text.isNotEmpty) {
                  setState(() {
                    shelters.add({
                      "name": nameController.text,
                      "address": addressController.text,
                      "distance": distanceController.text,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _deleteShelter(int index) {
    setState(() {
      shelters.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Shelter Locations', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: shelters.length,
        itemBuilder: (context, index) {
          return ShelterCard(
            name: shelters[index]["name"]!,
            address: shelters[index]["address"]!,
            distance: shelters[index]["distance"]!,
            onDelete: () => _deleteShelter(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addShelter,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class ShelterCard extends StatelessWidget {
  final String name;
  final String address;
  final String distance;
  final VoidCallback onDelete;

  const ShelterCard({
    required this.name,
    required this.address,
    required this.distance,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(address, style: TextStyle(color: Colors.white70)),
                SizedBox(height: 5),
                Text("Distance: $distance", style: TextStyle(color: Colors.blue)),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
