import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class AstrologerModel extends UserModel {
  final List<String> skills;
  final int experienceYears;
  final double rating;
  final int totalConsultations;
  final List<String> languages;
  final Map<String, dynamic>? availability;
  final Map<String, double> pricing;
  final bool isVerified;
  final String? bio;
  final List<String> specialties;
  final double walletBalance;
  final int totalEarnings;
  final List<Map<String, dynamic>>? reviews;

  AstrologerModel({
    required super.id,
    required super.email,
    super.phoneNumber,
    super.displayName,
    super.photoUrl,
    required super.role,
    required super.createdAt,
    super.lastLoginAt,
    super.isActive,
    required this.skills,
    required this.experienceYears,
    required this.rating,
    required this.totalConsultations,
    required this.languages,
    this.availability,
    required this.pricing,
    this.isVerified = false,
    this.bio,
    required this.specialties,
    this.walletBalance = 0.0,
    this.totalEarnings = 0,
    this.reviews,
  }) : super(role: 'astrologer');

  factory AstrologerModel.fromMap(Map<String, dynamic> map, String id) {
    final userModel = UserModel.fromMap(map, id);
    return AstrologerModel(
      id: id,
      email: userModel.email,
      phoneNumber: userModel.phoneNumber,
      displayName: userModel.displayName,
      photoUrl: userModel.photoUrl,
      role: 'astrologer',
      createdAt: userModel.createdAt,
      lastLoginAt: userModel.lastLoginAt,
      isActive: userModel.isActive,
      skills: List<String>.from(map['skills'] ?? []),
      experienceYears: map['experienceYears'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      totalConsultations: map['totalConsultations'] ?? 0,
      languages: List<String>.from(map['languages'] ?? []),
      availability: map['availability'],
      pricing: Map<String, double>.from(map['pricing'] ?? {}),
      isVerified: map['isVerified'] ?? false,
      bio: map['bio'],
      specialties: List<String>.from(map['specialties'] ?? []),
      walletBalance: (map['walletBalance'] ?? 0.0).toDouble(),
      totalEarnings: map['totalEarnings'] ?? 0,
      reviews: map['reviews'] != null 
          ? List<Map<String, dynamic>>.from(map['reviews']) 
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'skills': skills,
      'experienceYears': experienceYears,
      'rating': rating,
      'totalConsultations': totalConsultations,
      'languages': languages,
      'availability': availability,
      'pricing': pricing,
      'isVerified': isVerified,
      'bio': bio,
      'specialties': specialties,
      'walletBalance': walletBalance,
      'totalEarnings': totalEarnings,
      'reviews': reviews,
    });
    return map;
  }
}

