class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String gender;
  final String? address;
  final String? bloodGroup;
  final String? insuranceId;
  final List<String>? allergies;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    this.address,
    this.bloodGroup,
    this.insuranceId,
    this.allergies,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      gender: json['gender'],
      address: json['address'],
      bloodGroup: json['blood_group'],
      insuranceId: json['insurance_id'],
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'])
          : null,
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'address': address,
      'blood_group': bloodGroup,
      'insurance_id': insuranceId,
      'allergies': allergies,
      'profile_image': profileImage,
    };
  }
}
