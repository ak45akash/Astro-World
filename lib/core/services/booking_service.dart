import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/booking_model.dart';
import '../constants/app_constants.dart';
import 'astrology_service.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AstrologyService _astrologyService = AstrologyService();

  Future<BookingModel> createBooking({
    required String userId,
    required String astrologerId,
    required ConsultationType type,
    required DateTime scheduledAt,
    required int durationMinutes,
    required double amount,
    required Map<String, dynamic> userBirthDetails,
  }) async {
    // Generate Kundli and Varshphal before creating booking
    Map<String, dynamic>? kundliData;
    Map<String, dynamic>? varshphalData;

    try {
      kundliData = await _astrologyService.generateKundli(
        name: userBirthDetails['name'] ?? '',
        day: userBirthDetails['day'],
        month: userBirthDetails['month'],
        year: userBirthDetails['year'],
        hour: userBirthDetails['hour'],
        minute: userBirthDetails['minute'],
        latitude: userBirthDetails['latitude'],
        longitude: userBirthDetails['longitude'],
        timezone: userBirthDetails['timezone'],
      );

      varshphalData = await _astrologyService.generateVarshphal(
        day: userBirthDetails['day'],
        month: userBirthDetails['month'],
        year: userBirthDetails['year'],
        hour: userBirthDetails['hour'],
        minute: userBirthDetails['minute'],
        latitude: userBirthDetails['latitude'],
        longitude: userBirthDetails['longitude'],
        timezone: userBirthDetails['timezone'],
        varshphalYear: DateTime.now().year,
      );
    } catch (e) {
      // Log error but continue with booking creation
      print('Error generating astrology data: $e');
    }

    final booking = BookingModel(
      id: '',
      userId: userId,
      astrologerId: astrologerId,
      type: type,
      scheduledAt: scheduledAt,
      durationMinutes: durationMinutes,
      amount: amount,
      status: BookingStatus.pending,
      createdAt: DateTime.now(),
      kundliData: kundliData,
      varshphalData: varshphalData,
    );

    final docRef = await _firestore
        .collection(AppConstants.collectionBookings)
        .add(booking.toMap());

    return booking.copyWith(id: docRef.id);
  }

  Future<BookingModel?> getBooking(String bookingId) async {
    final doc = await _firestore
        .collection(AppConstants.collectionBookings)
        .doc(bookingId)
        .get();

    if (doc.exists) {
      return BookingModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Stream<List<BookingModel>> getUserBookings(String userId) {
    return _firestore
        .collection(AppConstants.collectionBookings)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Stream<List<BookingModel>> getAstrologerBookings(String astrologerId) {
    return _firestore
        .collection(AppConstants.collectionBookings)
        .where('astrologerId', isEqualTo: astrologerId)
        .orderBy('scheduledAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> updateBookingStatus({
    required String bookingId,
    required BookingStatus status,
    String? cancellationReason,
  }) async {
    final updates = <String, dynamic>{
      'status': status.toString().split('.').last,
    };

    if (status == BookingStatus.completed) {
      updates['completedAt'] = FieldValue.serverTimestamp();
    }

    if (cancellationReason != null) {
      updates['cancellationReason'] = cancellationReason;
    }

    await _firestore
        .collection(AppConstants.collectionBookings)
        .doc(bookingId)
        .update(updates);
  }

}

