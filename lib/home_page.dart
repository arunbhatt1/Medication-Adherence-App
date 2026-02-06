import 'package:flutter/material.dart';
import 'add_medication_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> medications = [];

  void addMedication(Map<String, String> med) {
    setState(() {
      medications.add(med);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Medications"),
        automaticallyImplyLeading: false, // 🚫 disables back to login
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddMedicationPage(),
            ),
          );

          if (result != null) {
            addMedication(result);
          }
        },
      ),
      body: medications.isEmpty
          ? const Center(child: Text("No medications added"))
          : ListView.builder(
              itemCount: medications.length,
              itemBuilder: (context, index) {
                final med = medications[index];
                return ListTile(
                  title: Text(med['name']!),
                  subtitle: Text(med['dosage']!),
                );
              },
            ),
    );
  }
}