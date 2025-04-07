import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'EmergencyContactsScreen.dart';
import 'profile.dart';
import 'RescueRequestScreen.dart';
import 'FloodAlertsScreen.dart';
import 'LoginPage.dart';
import 'ShelterLocationsScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // AppBar with hamburger menu
      appBar: AppBar(
        title: const Text('Flood Rescue App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),

      // Navigation Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/Rahimul.png"),
                radius: 40,
              ),
              accountName: const Text("Rahimul", style: TextStyle(fontSize: 18)),
              accountEmail: const Text("2021831050@student.sust.edu"),
            ),
            _buildDrawerItem(Icons.home, "Home", context),
            _buildDrawerItem(Icons.favorite, "Favourites", context),
            _buildDrawerItem(Icons.work, "Workflow", context),
            _buildDrawerItem(Icons.update, "Updates", context),
            const Divider(),
            _buildDrawerItem(Icons.extension, "Plugins", context),
            _buildDrawerItem(Icons.notifications, "Notifications", context),

            // 🔒 Logout Item
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black54),
              title: const Text("Logout", style: TextStyle(fontSize: 16)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),

      // Body Grid View
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            FeatureCard(
              icon: Icons.sos,
              label: 'Rescue Request',
              color: Colors.red,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RescueRequestScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.house,
              label: 'Shelter Locations',
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShelterLocationsScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.contacts,
              label: 'Emergency Contacts',
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyContactsScreen()),
              ),
            ),
            FeatureCard(
              icon: Icons.map,
              label: 'Flood Alerts',
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FloodAlertsScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer Item Builder
  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

// ✅ FeatureCard Widget
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
