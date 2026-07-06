class MedicalRecord {
  final String id;
  final String patientId;
  final String doctorId;
  final String? doctorName;
  final DateTime visitDate;
  final String diagnosis;
  final String? symptoms;
  final String? treatment;
  final List<Prescription>? prescriptions;
  final List<String>? labResults;
  final String? notes;
  final DateTime createdAt;

  MedicalRecord({
    required this.id,
    required this.patientId,
    required this.doctorId,
    this.doctorName,
    required this.visitDate,
    required this.diagnosis,
    this.symptoms,
    this.treatment,
    this.prescriptions,
    this.labResults,
    this.notes,
    required this.createdAt,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      doctorName: json['doctor_name'],
      visitDate: DateTime.parse(json['visit_date']),
      diagnosis: json['diagnosis'],
      symptoms: json['symptoms'],
      treatment: json['treatment'],
      prescriptions: json['prescriptions'] != null
          ? (json['prescriptions'] as List)
              .map((p) => Prescription.fromJson(p))
              .toList()
          : null,
      labResults: json['lab_results'] != null
          ? List<String>.from(json['lab_results'])
          : null,
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Prescription {
  final String medicineName;
  final String dosage;
  final String frequency;
  final String duration;
  final String? instructions;

  Prescription({
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.instructions,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      medicineName: json['medicine_name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      duration: json['duration'],
      instructions: json['instructions'],
    );
  }
}
