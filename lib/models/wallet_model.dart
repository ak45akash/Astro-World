import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType {
  credit,
  debit,
}

enum TransactionCategory {
  booking,
  refund,
  payout,
  referral,
  bonus,
  aiQuestion,
  walletTopUp,
}

class WalletTransaction {
  final String id;
  final String userId;
  final double amount;
  final TransactionType type;
  final TransactionCategory category;
  final String? description;
  final String? referenceId; // bookingId, paymentId, etc.
  final DateTime timestamp;
  final double balanceAfter;

  WalletTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.category,
    this.description,
    this.referenceId,
    required this.timestamp,
    required this.balanceAfter,
  });

  factory WalletTransaction.fromMap(Map<String, dynamic> map, String id) {
    return WalletTransaction(
      id: id,
      userId: map['userId'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => TransactionType.credit,
      ),
      category: TransactionCategory.values.firstWhere(
        (e) => e.toString().split('.').last == map['category'],
        orElse: () => TransactionCategory.booking,
      ),
      description: map['description'],
      referenceId: map['referenceId'],
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      balanceAfter: (map['balanceAfter'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'type': type.toString().split('.').last,
      'category': category.toString().split('.').last,
      'description': description,
      'referenceId': referenceId,
      'timestamp': Timestamp.fromDate(timestamp),
      'balanceAfter': balanceAfter,
    };
  }
}

class WalletModel {
  final String id;
  final String userId;
  final double balance;
  final DateTime lastUpdated;
  final List<String> transactionIds;

  WalletModel({
    required this.id,
    required this.userId,
    required this.balance,
    required this.lastUpdated,
    this.transactionIds = const [],
  });

  factory WalletModel.fromMap(Map<String, dynamic> map, String id) {
    return WalletModel(
      id: id,
      userId: map['userId'] ?? '',
      balance: (map['balance'] ?? 0.0).toDouble(),
      lastUpdated: (map['lastUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),
      transactionIds: List<String>.from(map['transactionIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'balance': balance,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'transactionIds': transactionIds,
    };
  }
}

