import 'package:cloud_firestore/cloud_firestore.dart';

enum BookingStatus {
  pending,
  confirmed,
  ongoing,
  completed,
  cancelled,
  refunded,
}

enum ConsultationType {
  chat,
  voice,
  video,
}

class BookingModel {
  final String id;
  final String userId;
  final String astrologerId;
  final ConsultationType type;
  final DateTime scheduledAt;
  final int durationMinutes;
  final double amount;
  final BookingStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? paymentId;
  final String? razorpayOrderId;
  final String? agoraChannelName;
  final String? agoraToken;
  final Map<String, dynamic>? kundliData;
  final Map<String, dynamic>? varshphalData;
  final String? reviewId;
  final String? cancellationReason;

  BookingModel({
    required this.id,
    required this.userId,
    required this.astrologerId,
    required this.type,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.paymentId,
    this.razorpayOrderId,
    this.agoraChannelName,
    this.agoraToken,
    this.kundliData,
    this.varshphalData,
    this.reviewId,
    this.cancellationReason,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
    return BookingModel(
      id: id,
      userId: map['userId'] ?? '',
      astrologerId: map['astrologerId'] ?? '',
      type: ConsultationType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => ConsultationType.chat,
      ),
      scheduledAt: (map['scheduledAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      durationMinutes: map['durationMinutes'] ?? 30,
      amount: (map['amount'] ?? 0.0).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
        orElse: () => BookingStatus.pending,
      ),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      completedAt: (map['completedAt'] as Timestamp?)?.toDate(),
      paymentId: map['paymentId'],
      razorpayOrderId: map['razorpayOrderId'],
      agoraChannelName: map['agoraChannelName'],
      agoraToken: map['agoraToken'],
      kundliData: map['kundliData'],
      varshphalData: map['varshphalData'],
      reviewId: map['reviewId'],
      cancellationReason: map['cancellationReason'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'astrologerId': astrologerId,
      'type': type.toString().split('.').last,
      'scheduledAt': Timestamp.fromDate(scheduledAt),
      'durationMinutes': durationMinutes,
      'amount': amount,
      'status': status.toString().split('.').last,
      'createdAt': Timestamp.fromDate(createdAt),
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'paymentId': paymentId,
      'razorpayOrderId': razorpayOrderId,
      'agoraChannelName': agoraChannelName,
      'agoraToken': agoraToken,
      'kundliData': kundliData,
      'varshphalData': varshphalData,
      'reviewId': reviewId,
      'cancellationReason': cancellationReason,
    };
  }
}

