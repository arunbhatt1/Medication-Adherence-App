import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'medication_model.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final nameController = TextEditingController();
  final dosageController = TextEditingController();

  List<Medication> medications = [];

  @override
  void initState() {
    super.initState();
    loadMedications();
  }

  Future<void> loadMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('medications');

    if (data != null) {
      final List decoded = jsonDecode(data);
      setState(() {
        medications =
            decoded.map((e) => Medication.fromJson(e)).toList();
      });
    }
  }

  Future<void> saveMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        jsonEncode(medications.map((e) => e.toJson()).toList());
    await prefs.setString('medications', encoded);
  }

  void addMedication() async {
    setState(() {
      medications.add(
        Medication(
          name: nameController.text,
          dosage: dosageController.text,
        ),
      );
    });

    await saveMedications();

    nameController.clear();
    dosageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Medications")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: "Medicine Name"),
            ),
            TextField(
              controller: dosageController,
              decoration: const InputDecoration(labelText: "Dosage"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addMedication,
              child: const Text("Add Medication"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(medications[index].name),
                    subtitle: Text(medications[index].dosage),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
