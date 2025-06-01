import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TipsDetailView extends StatelessWidget {
  const TipsDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ambil data dari arguments GetX
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Tips Detail')),
        body: Center(child: Text('Data tips tidak tersedia')),
      );
    }

    final IconData icon = args['icon'];
    final String title = args['title'] ?? 'No Title';
    final String description = args['description'] ?? 'No Description';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
