class Medication {
  final String name;
  final String dosage;
  final String? time;
  final DateTime? createdAt;

  Medication({
    required this.name,
    required this.dosage,
    this.time,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      time: json['time'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Medication(name: $name, dosage: $dosage, time: $time)';
  }
}