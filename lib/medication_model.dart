class Medication {
  final String name;
  final String dosage;

  Medication({required this.name, required this.dosage});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'],
      dosage: json['dosage'],
    );
  }
}
