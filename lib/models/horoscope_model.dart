import 'package:cloud_firestore/cloud_firestore.dart';

class HoroscopeModel {
  final String id;
  final String zodiacSign;
  final DateTime date;
  final String prediction;
  final String? love;
  final String? career;
  final String? health;
  final String? finance;
  final int luckyNumber;
  final String luckyColor;
  final DateTime createdAt;

  HoroscopeModel({
    required this.id,
    required this.zodiacSign,
    required this.date,
    required this.prediction,
    this.love,
    this.career,
    this.health,
    this.finance,
    required this.luckyNumber,
    required this.luckyColor,
    required this.createdAt,
  });

  factory HoroscopeModel.fromMap(Map<String, dynamic> map, String id) {
    return HoroscopeModel(
      id: id,
      zodiacSign: map['zodiacSign'] ?? '',
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      prediction: map['prediction'] ?? '',
      love: map['love'],
      career: map['career'],
      health: map['health'],
      finance: map['finance'],
      luckyNumber: map['luckyNumber'] ?? 0,
      luckyColor: map['luckyColor'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'zodiacSign': zodiacSign,
      'date': Timestamp.fromDate(date),
      'prediction': prediction,
      'love': love,
      'career': career,
      'health': health,
      'finance': finance,
      'luckyNumber': luckyNumber,
      'luckyColor': luckyColor,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  HoroscopeModel copyWith({
    String? id,
    String? zodiacSign,
    DateTime? date,
    String? prediction,
    String? love,
    String? career,
    String? health,
    String? finance,
    int? luckyNumber,
    String? luckyColor,
    DateTime? createdAt,
  }) {
    return HoroscopeModel(
      id: id ?? this.id,
      zodiacSign: zodiacSign ?? this.zodiacSign,
      date: date ?? this.date,
      prediction: prediction ?? this.prediction,
      love: love ?? this.love,
      career: career ?? this.career,
      health: health ?? this.health,
      finance: finance ?? this.finance,
      luckyNumber: luckyNumber ?? this.luckyNumber,
      luckyColor: luckyColor ?? this.luckyColor,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

