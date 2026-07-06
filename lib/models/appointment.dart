class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String? patientName;
  final String? doctorName;
  final String? doctorSpecialization;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentStatus status;
  final AppointmentType type;
  final String? reason;
  final String? notes;
  final double? fee;
  final DateTime createdAt;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    this.patientName,
    this.doctorName,
    this.doctorSpecialization,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
    required this.type,
    this.reason,
    this.notes,
    this.fee,
    required this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      patientName: json['patient_name'],
      doctorName: json['doctor_name'],
      doctorSpecialization: json['doctor_specialization'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      timeSlot: json['time_slot'],
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.scheduled,
      ),
      type: AppointmentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AppointmentType.consultation,
      ),
      reason: json['reason'],
      notes: json['notes'],
      fee: json['fee']?.toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_date': appointmentDate.toIso8601String(),
      'time_slot': timeSlot,
      'status': status.name,
      'type': type.name,
      'reason': reason,
      'notes': notes,
      'fee': fee,
    };
  }
}

enum AppointmentStatus {
  scheduled,
  confirmed,
  inProgress,
  completed,
  cancelled,
  noShow,
}

enum AppointmentType {
  consultation,
  followUp,
  emergency,
  labTest,
  surgery,
}
