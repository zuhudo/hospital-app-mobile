class Doctor {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String specialization;
  final String? department;
  final String? qualification;
  final int? experienceYears;
  final double? consultationFee;
  final String? profileImage;
  final double? rating;
  final bool isAvailable;
  final List<String>? availableDays;
  final String? bio;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.specialization,
    this.department,
    this.qualification,
    this.experienceYears,
    this.consultationFee,
    this.profileImage,
    this.rating,
    this.isAvailable = true,
    this.availableDays,
    this.bio,
  });

  String get fullName => 'Dr. $firstName $lastName';

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      specialization: json['specialization'],
      department: json['department'],
      qualification: json['qualification'],
      experienceYears: json['experience_years'],
      consultationFee: json['consultation_fee']?.toDouble(),
      profileImage: json['profile_image'],
      rating: json['rating']?.toDouble(),
      isAvailable: json['is_available'] ?? true,
      availableDays: json['available_days'] != null
          ? List<String>.from(json['available_days'])
          : null,
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'specialization': specialization,
      'department': department,
      'qualification': qualification,
      'experience_years': experienceYears,
      'consultation_fee': consultationFee,
      'profile_image': profileImage,
      'rating': rating,
      'is_available': isAvailable,
      'available_days': availableDays,
      'bio': bio,
    };
  }
}
