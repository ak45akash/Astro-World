import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/wallet_model.dart';
import '../constants/app_constants.dart';

class WalletService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<WalletModel?> getWallet(String userId) async {
    final doc = await _firestore
        .collection(AppConstants.collectionWallets)
        .doc(userId)
        .get();

    if (doc.exists) {
      return WalletModel.fromMap(doc.data()!, doc.id);
    }

    // Create new wallet if doesn't exist
    final wallet = WalletModel(
      id: userId,
      userId: userId,
      balance: 0.0,
      lastUpdated: DateTime.now(),
    );

    await _firestore
        .collection(AppConstants.collectionWallets)
        .doc(userId)
        .set(wallet.toMap());

    return wallet;
  }

  Future<void> addTransaction({
    required String userId,
    required double amount,
    required TransactionType type,
    required TransactionCategory category,
    String? description,
    String? referenceId,
  }) async {
    final wallet = await getWallet(userId);
    if (wallet == null) return;

    final newBalance = type == TransactionType.credit
        ? wallet.balance + amount
        : wallet.balance - amount;

    final transaction = WalletTransaction(
      id: '',
      userId: userId,
      amount: amount,
      type: type,
      category: category,
      description: description,
      referenceId: referenceId,
      timestamp: DateTime.now(),
      balanceAfter: newBalance,
    );

    final batch = _firestore.batch();

    // Add transaction
    final transactionRef = _firestore
        .collection(AppConstants.collectionWallets)
        .doc(userId)
        .collection('transactions')
        .doc();
    batch.set(transactionRef, transaction.toMap());

    // Update wallet balance
    final walletRef = _firestore
        .collection(AppConstants.collectionWallets)
        .doc(userId);
    batch.update(walletRef, {
      'balance': newBalance,
      'lastUpdated': FieldValue.serverTimestamp(),
      'transactionIds': FieldValue.arrayUnion([transactionRef.id]),
    });

    await batch.commit();
  }

  Stream<List<WalletTransaction>> getTransactions(String userId) {
    return _firestore
        .collection(AppConstants.collectionWallets)
        .doc(userId)
        .collection('transactions')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => WalletTransaction.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> processReferralBonus({
    required String referrerId,
    required String referredUserId,
  }) async {
    await addTransaction(
      userId: referrerId,
      amount: AppConstants.referralBonus,
      type: TransactionType.credit,
      category: TransactionCategory.referral,
      description: 'Referral bonus for referring a new user',
      referenceId: referredUserId,
    );
  }
}

