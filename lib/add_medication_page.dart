import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  // ✅ LOCAL IN-MEMORY STORAGE
  static final List<Map<String, String>> medications = [];

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final nameController = TextEditingController();
  final dosageController = TextEditingController();

  TimeOfDay? selectedTime;

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void saveMedication() {
    final name = nameController.text.trim();
    final dosage = dosageController.text.trim();

    if (name.isEmpty || dosage.isEmpty || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields & pick time")),
      );
      return;
    }

    setState(() {
      AddMedicationPage.medications.add({
        "name": name,
        "dosage": dosage,
        "time": selectedTime!.format(context),
      });
    });

    nameController.clear();
    dosageController.clear();
    selectedTime = null;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Medication"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Medication Name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dosageController,
              decoration: const InputDecoration(
                labelText: "Dosage (e.g. 1 tablet)",
              ),
            ),
            const SizedBox(height: 10),

            // ⏰ TIME PICKER
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTime == null
                        ? "No reminder time selected"
                        : "Reminder: ${selectedTime!.format(context)}",
                  ),
                ),
                TextButton(
                  onPressed: pickTime,
                  child: const Text("Pick Time"),
                ),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveMedication,
              child: const Text("Save Medication"),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: AddMedicationPage.medications.isEmpty
                  ? const Center(child: Text("No medications added"))
                  : ListView.builder(
                      itemCount: AddMedicationPage.medications.length,
                      itemBuilder: (context, index) {
                        final med =
                            AddMedicationPage.medications[index];
                        return Card(
                          child: ListTile(
                            title: Text(med["name"]!),
                            subtitle: Text(
                              "${med["dosage"]} • ⏰ ${med["time"]}",
                            ),
                          ),
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