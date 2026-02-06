import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_medication_page.dart';
import 'login_page.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  Future<void> logout(BuildContext context) async {
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
        title: const Text("Patient Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: const AddMedicationPage(),
    );
  }
}