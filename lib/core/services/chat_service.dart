import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../constants/app_constants.dart';

class ChatMessage {
  final String id;
  final String bookingId;
  final String senderId;
  final String message;
  final DateTime timestamp;
  final String? attachmentUrl;
  final String? attachmentType;
  final bool isSeen;

  ChatMessage({
    required this.id,
    required this.bookingId,
    required this.senderId,
    required this.message,
    required this.timestamp,
    this.attachmentUrl,
    this.attachmentType,
    this.isSeen = false,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map, String id) {
    return ChatMessage(
      id: id,
      bookingId: map['bookingId'] ?? '',
      senderId: map['senderId'] ?? '',
      message: map['message'] ?? '',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      attachmentUrl: map['attachmentUrl'],
      attachmentType: map['attachmentType'],
      isSeen: map['isSeen'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'senderId': senderId,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
      'isSeen': isSeen,
    };
  }
}

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<List<ChatMessage>> getChatMessages(String bookingId) {
    return _firestore
        .collection(AppConstants.collectionChats)
        .where('bookingId', isEqualTo: bookingId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatMessage.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> sendMessage({
    required String bookingId,
    required String senderId,
    required String message,
    String? attachmentPath,
    String? attachmentType,
  }) async {
    String? attachmentUrl;

    if (attachmentPath != null) {
      // Upload attachment - TODO: Implement file upload
      // final ref = _storage.ref().child(
      //   '${AppConstants.storageChatAttachments}/${DateTime.now().millisecondsSinceEpoch}',
      // );
      // await ref.putFile(attachmentFile);
      // attachmentUrl = await ref.getDownloadURL();
    }

    await _firestore.collection(AppConstants.collectionChats).add({
      'bookingId': bookingId,
      'senderId': senderId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
      'isSeen': false,
    });
  }

  Future<void> markAsSeen(String messageId) async {
    await _firestore
        .collection(AppConstants.collectionChats)
        .doc(messageId)
        .update({'isSeen': true});
  }

  Future<void> markAllAsSeen(String bookingId, String userId) async {
    final messages = await _firestore
        .collection(AppConstants.collectionChats)
        .where('bookingId', isEqualTo: bookingId)
        .where('senderId', isNotEqualTo: userId)
        .get();

    final batch = _firestore.batch();
    for (var doc in messages.docs) {
      batch.update(doc.reference, {'isSeen': true});
    }
    await batch.commit();
  }
}

