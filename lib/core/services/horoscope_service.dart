import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/horoscope_model.dart';
import '../constants/app_constants.dart';
import 'astrology_service.dart';

class HoroscopeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AstrologyService _astrologyService = AstrologyService();

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

    // Fetch from API if not cached
    try {
      final data = await _astrologyService.getDailyHoroscope(
        zodiacSign: zodiacSign,
        date: date,
      );

      final horoscope = HoroscopeModel(
        id: '',
        zodiacSign: zodiacSign,
        date: date,
        prediction: data['prediction'] ?? '',
        love: data['love'],
        career: data['career'],
        health: data['health'],
        finance: data['finance'],
        luckyNumber: data['luckyNumber'] ?? 0,
        luckyColor: data['luckyColor'] ?? '',
        createdAt: DateTime.now(),
      );

      final docRef = await _firestore
          .collection(AppConstants.collectionHoroscopes)
          .add(horoscope.toMap());

      final savedDoc = await docRef.get();
      return HoroscopeModel.fromMap(savedDoc.data()!, savedDoc.id);
    } catch (e) {
      return null;
    }
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

