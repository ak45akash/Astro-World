import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../lib/models/horoscope_model.dart';

void main() {
  group('HoroscopeModel', () {
    test('creates model with all required fields', () {
      final model = HoroscopeModel(
        id: 'test-id',
        zodiacSign: 'Aries',
        date: DateTime(2024, 1, 15),
        prediction: 'Test prediction',
        luckyNumber: 7,
        luckyColor: 'Red',
        createdAt: DateTime.now(),
      );

      expect(model.id, 'test-id');
      expect(model.zodiacSign, 'Aries');
      expect(model.prediction, 'Test prediction');
      expect(model.luckyNumber, 7);
      expect(model.luckyColor, 'Red');
    });

    test('creates model with optional fields', () {
      final model = HoroscopeModel(
        id: 'test-id',
        zodiacSign: 'Taurus',
        date: DateTime(2024, 1, 15),
        prediction: 'Test prediction',
        love: 'Love prediction',
        career: 'Career prediction',
        health: 'Health prediction',
        finance: 'Finance prediction',
        family: 'Family prediction',
        mood: 'Mood prediction',
        luck: 'Luck prediction',
        spirituality: 'Spirituality prediction',
        loveRating: 4,
        moodRating: 5,
        careerRating: 3,
        healthRating: 4,
        luckRating: 5,
        luckyNumber: 7,
        luckyColor: 'Blue',
        luckyTime: '10:00 AM',
        luckyDirection: 'North',
        luckyStone: 'Diamond',
        dailyMantra: 'Om Shanti',
        affirmation: 'I am blessed',
        bestActivity: 'Meditation',
        avoidToday: 'Conflict',
        planetaryHighlight: 'Sun is strong',
        planetaryInfluence: {'Sun': 'Strong energy'},
        tithi: 'Dwitiya',
        nakshatra: 'Rohini',
        yoga: 'Vajra',
        karana: 'Bava',
        rahuKalam: '07:30 - 09:00',
        gulikaKalam: '10:30 - 12:00',
        yamagandaKalam: '13:30 - 15:00',
        tarotCardName: 'The Fool',
        tarotCardMeaning: 'New beginnings',
        tarotCardImageUrl: 'https://example.com/card.jpg',
        morningEnergy: 7,
        afternoonEnergy: 5,
        eveningEnergy: 8,
        dateRange: 'Mar 21 - Apr 19',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(model.love, 'Love prediction');
      expect(model.loveRating, 4);
      expect(model.luckyTime, '10:00 AM');
      expect(model.dailyMantra, 'Om Shanti');
      expect(model.morningEnergy, 7);
    });

    test('converts to map correctly', () {
      final model = HoroscopeModel(
        id: 'test-id',
        zodiacSign: 'Gemini',
        date: DateTime(2024, 1, 15),
        prediction: 'Test prediction',
        luckyNumber: 7,
        luckyColor: 'Yellow',
        createdAt: DateTime(2024, 1, 15),
      );

      final map = model.toMap();
      expect(map['zodiacSign'], 'Gemini');
      expect(map['prediction'], 'Test prediction');
      expect(map['luckyNumber'], 7);
      expect(map['luckyColor'], 'Yellow');
    });

    test('creates from map correctly', () {
      final map = {
        'zodiacSign': 'Cancer',
        'date': Timestamp.fromDate(DateTime(2024, 1, 15)),
        'prediction': 'Test prediction',
        'luckyNumber': 7,
        'luckyColor': 'Silver',
        'createdAt': Timestamp.fromDate(DateTime(2024, 1, 15)),
        'love': 'Love prediction',
        'loveRating': 4,
      };

      final model = HoroscopeModel.fromMap(map, 'test-id');
      expect(model.id, 'test-id');
      expect(model.zodiacSign, 'Cancer');
      expect(model.prediction, 'Test prediction');
      expect(model.love, 'Love prediction');
      expect(model.loveRating, 4);
    });

    test('copyWith creates new instance with updated fields', () {
      final original = HoroscopeModel(
        id: 'test-id',
        zodiacSign: 'Leo',
        date: DateTime(2024, 1, 15),
        prediction: 'Original prediction',
        luckyNumber: 7,
        luckyColor: 'Gold',
        createdAt: DateTime(2024, 1, 15),
      );

      final updated = original.copyWith(
        prediction: 'Updated prediction',
        luckyNumber: 9,
      );

      expect(updated.id, 'test-id');
      expect(updated.zodiacSign, 'Leo');
      expect(updated.prediction, 'Updated prediction');
      expect(updated.luckyNumber, 9);
      expect(updated.luckyColor, 'Gold'); // Unchanged
    });

    test('updatedAtOrCreated returns updatedAt if available', () {
      final now = DateTime.now();
      final model = HoroscopeModel(
        id: 'test-id',
        zodiacSign: 'Virgo',
        date: DateTime(2024, 1, 15),
        prediction: 'Test',
        luckyNumber: 7,
        luckyColor: 'Green',
        createdAt: DateTime(2024, 1, 15),
        updatedAt: now,
      );

      expect(model.updatedAtOrCreated, now);
    });

    test('updatedAtOrCreated returns createdAt if updatedAt is null', () {
      final createdAt = DateTime(2024, 1, 15);
      final model = HoroscopeModel(
        id: 'test-id',
        zodiacSign: 'Libra',
        date: DateTime(2024, 1, 15),
        prediction: 'Test',
        luckyNumber: 7,
        luckyColor: 'Pink',
        createdAt: createdAt,
      );

      expect(model.updatedAtOrCreated, createdAt);
    });
  });
}

