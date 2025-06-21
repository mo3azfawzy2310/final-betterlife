class DoctorModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String speciality;
  final String? pictureUrl;
  final double rating;
  final int reviewCount;
  final String? location;
  final double? distance;
  final bool? isFavorite;
  final int yearsOfExperience;
  final int patientCount;
  final double newVisitPrice;
  final String? about;

  DoctorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.speciality,
    this.pictureUrl,
    required this.rating,
    required this.reviewCount,
    this.location,
    this.distance,
    this.isFavorite,
    required this.yearsOfExperience,
    required this.patientCount,
    required this.newVisitPrice,
    this.about,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Doctor',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      speciality: json['speciality'] ?? json['specialization'] ?? 'General',
      pictureUrl: json['pictureUrl'] ?? json['image'],
      rating: (json['rating'] != null) ? json['rating'].toDouble() : 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      location: json['location'],
      distance: json['distance']?.toDouble(),
      isFavorite: json['isFavorite'] ?? false,
      yearsOfExperience: json['yearsOfExperience'] ?? json['experience'] ?? 0,
      patientCount: json['patientCount'] ?? 0,
      newVisitPrice: (json['newVisitPrice'] != null) ? json['newVisitPrice'].toDouble() : 0.0,
      about: json['about'] ?? json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'speciality': speciality,
      'pictureUrl': pictureUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'location': location,
      'distance': distance,
      'isFavorite': isFavorite,
      'yearsOfExperience': yearsOfExperience,
      'patientCount': patientCount,
      'newVisitPrice': newVisitPrice,
      'about': about,
    };
  }

  @override
  String toString() {
    return 'DoctorModel(id: $id, name: $name, speciality: $speciality, rating: $rating)';
  }
} 