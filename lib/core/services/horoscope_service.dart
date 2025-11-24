import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/horoscope_model.dart';
import '../constants/app_constants.dart';

class HoroscopeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<HoroscopeModel?> getDailyHoroscope({
    required String zodiacSign,
    required DateTime date,
  }) async {
    // Check cache first - use Timestamp for date comparison
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    final doc = await _firestore
        .collection(AppConstants.collectionHoroscopes)
        .where('zodiacSign', isEqualTo: zodiacSign)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .limit(1)
        .get();

    if (doc.docs.isNotEmpty) {
      return HoroscopeModel.fromMap(doc.docs.first.data(), doc.docs.first.id);
    }

    // Don't fetch from API - only read from Firestore
    // Cloud Function will populate Firestore daily
    return null;
  }

  Future<List<HoroscopeModel>> getAllDailyHoroscopes(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    final snapshot = await _firestore
        .collection(AppConstants.collectionHoroscopes)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .get();

    return snapshot.docs
        .map((doc) => HoroscopeModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Stream<List<HoroscopeModel>> getHoroscopesStream(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return _firestore
        .collection(AppConstants.collectionHoroscopes)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => HoroscopeModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
}

