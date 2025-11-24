import 'package:cloud_firestore/cloud_firestore.dart';

class HoroscopeModel {
  final String id;
  final String zodiacSign;
  final DateTime date;
  final String prediction;
  
  // Sectioned predictions
  final String? love;
  final String? career;
  final String? health;
  final String? finance;
  final String? family;
  final String? mood;
  final String? luck;
  final String? spirituality;
  
  // Star ratings (1-5)
  final int? loveRating;
  final int? moodRating;
  final int? careerRating;
  final int? healthRating;
  final int? luckRating;
  
  // Lucky elements
  final int luckyNumber;
  final String luckyColor;
  final String? luckyTime;
  final String? luckyDirection;
  final String? luckyStone;
  
  // Daily Mantra/Affirmation
  final String? dailyMantra;
  final String? affirmation;
  
  // Today at a Glance
  final String? bestActivity;
  final String? avoidToday;
  final String? planetaryHighlight;
  
  // Planetary influence
  final Map<String, String>? planetaryInfluence; // e.g., {'Sun': 'Strong energy', 'Moon': 'Emotional balance'}
  
  // Vedic/Panchang data
  final String? tithi;
  final String? nakshatra;
  final String? yoga;
  final String? karana;
  final String? rahuKalam;
  final String? gulikaKalam;
  final String? yamagandaKalam;
  
  // Tarot Card
  final String? tarotCardName;
  final String? tarotCardMeaning;
  final String? tarotCardImageUrl;
  
  // Mood/Energy meter (1-10 scale)
  final int? morningEnergy;
  final int? afternoonEnergy;
  final int? eveningEnergy;
  
  // Date range for zodiac sign
  final String? dateRange;
  
  final DateTime createdAt;
  final DateTime? updatedAt;

  HoroscopeModel({
    required this.id,
    required this.zodiacSign,
    required this.date,
    required this.prediction,
    this.love,
    this.career,
    this.health,
    this.finance,
    this.family,
    this.mood,
    this.luck,
    this.spirituality,
    this.loveRating,
    this.moodRating,
    this.careerRating,
    this.healthRating,
    this.luckRating,
    required this.luckyNumber,
    required this.luckyColor,
    this.luckyTime,
    this.luckyDirection,
    this.luckyStone,
    this.dailyMantra,
    this.affirmation,
    this.bestActivity,
    this.avoidToday,
    this.planetaryHighlight,
    this.planetaryInfluence,
    this.tithi,
    this.nakshatra,
    this.yoga,
    this.karana,
    this.rahuKalam,
    this.gulikaKalam,
    this.yamagandaKalam,
    this.tarotCardName,
    this.tarotCardMeaning,
    this.tarotCardImageUrl,
    this.morningEnergy,
    this.afternoonEnergy,
    this.eveningEnergy,
    this.dateRange,
    required this.createdAt,
    this.updatedAt,
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
      family: map['family'],
      mood: map['mood'],
      luck: map['luck'],
      spirituality: map['spirituality'],
      loveRating: map['loveRating'],
      moodRating: map['moodRating'],
      careerRating: map['careerRating'],
      healthRating: map['healthRating'],
      luckRating: map['luckRating'],
      luckyNumber: map['luckyNumber'] ?? 0,
      luckyColor: map['luckyColor'] ?? '',
      luckyTime: map['luckyTime'],
      luckyDirection: map['luckyDirection'],
      luckyStone: map['luckyStone'],
      dailyMantra: map['dailyMantra'],
      affirmation: map['affirmation'],
      bestActivity: map['bestActivity'],
      avoidToday: map['avoidToday'],
      planetaryHighlight: map['planetaryHighlight'],
      planetaryInfluence: map['planetaryInfluence'] != null
          ? Map<String, String>.from(map['planetaryInfluence'])
          : null,
      tithi: map['tithi'],
      nakshatra: map['nakshatra'],
      yoga: map['yoga'],
      karana: map['karana'],
      rahuKalam: map['rahuKalam'],
      gulikaKalam: map['gulikaKalam'],
      yamagandaKalam: map['yamagandaKalam'],
      tarotCardName: map['tarotCardName'],
      tarotCardMeaning: map['tarotCardMeaning'],
      tarotCardImageUrl: map['tarotCardImageUrl'],
      morningEnergy: map['morningEnergy'],
      afternoonEnergy: map['afternoonEnergy'],
      eveningEnergy: map['eveningEnergy'],
      dateRange: map['dateRange'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'zodiacSign': zodiacSign,
      'date': Timestamp.fromDate(date),
      'prediction': prediction,
      'luckyNumber': luckyNumber,
      'luckyColor': luckyColor,
      'createdAt': Timestamp.fromDate(createdAt),
    };
    
    if (love != null) map['love'] = love;
    if (career != null) map['career'] = career;
    if (health != null) map['health'] = health;
    if (finance != null) map['finance'] = finance;
    if (family != null) map['family'] = family;
    if (mood != null) map['mood'] = mood;
    if (luck != null) map['luck'] = luck;
    if (spirituality != null) map['spirituality'] = spirituality;
    if (loveRating != null) map['loveRating'] = loveRating;
    if (moodRating != null) map['moodRating'] = moodRating;
    if (careerRating != null) map['careerRating'] = careerRating;
    if (healthRating != null) map['healthRating'] = healthRating;
    if (luckRating != null) map['luckRating'] = luckRating;
    if (luckyTime != null) map['luckyTime'] = luckyTime;
    if (luckyDirection != null) map['luckyDirection'] = luckyDirection;
    if (luckyStone != null) map['luckyStone'] = luckyStone;
    if (dailyMantra != null) map['dailyMantra'] = dailyMantra;
    if (affirmation != null) map['affirmation'] = affirmation;
    if (bestActivity != null) map['bestActivity'] = bestActivity;
    if (avoidToday != null) map['avoidToday'] = avoidToday;
    if (planetaryHighlight != null) map['planetaryHighlight'] = planetaryHighlight;
    if (planetaryInfluence != null) map['planetaryInfluence'] = planetaryInfluence;
    if (tithi != null) map['tithi'] = tithi;
    if (nakshatra != null) map['nakshatra'] = nakshatra;
    if (yoga != null) map['yoga'] = yoga;
    if (karana != null) map['karana'] = karana;
    if (rahuKalam != null) map['rahuKalam'] = rahuKalam;
    if (gulikaKalam != null) map['gulikaKalam'] = gulikaKalam;
    if (yamagandaKalam != null) map['yamagandaKalam'] = yamagandaKalam;
    if (tarotCardName != null) map['tarotCardName'] = tarotCardName;
    if (tarotCardMeaning != null) map['tarotCardMeaning'] = tarotCardMeaning;
    if (tarotCardImageUrl != null) map['tarotCardImageUrl'] = tarotCardImageUrl;
    if (morningEnergy != null) map['morningEnergy'] = morningEnergy;
    if (afternoonEnergy != null) map['afternoonEnergy'] = afternoonEnergy;
    if (eveningEnergy != null) map['eveningEnergy'] = eveningEnergy;
    if (dateRange != null) map['dateRange'] = dateRange;
    if (updatedAt != null) map['updatedAt'] = Timestamp.fromDate(updatedAt!);
    
    return map;
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
    String? family,
    String? mood,
    String? luck,
    String? spirituality,
    int? loveRating,
    int? moodRating,
    int? careerRating,
    int? healthRating,
    int? luckRating,
    int? luckyNumber,
    String? luckyColor,
    String? luckyTime,
    String? luckyDirection,
    String? luckyStone,
    String? dailyMantra,
    String? affirmation,
    String? bestActivity,
    String? avoidToday,
    String? planetaryHighlight,
    Map<String, String>? planetaryInfluence,
    String? tithi,
    String? nakshatra,
    String? yoga,
    String? karana,
    String? rahuKalam,
    String? gulikaKalam,
    String? yamagandaKalam,
    String? tarotCardName,
    String? tarotCardMeaning,
    String? tarotCardImageUrl,
    int? morningEnergy,
    int? afternoonEnergy,
    int? eveningEnergy,
    String? dateRange,
    DateTime? createdAt,
    DateTime? updatedAt,
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
      family: family ?? this.family,
      mood: mood ?? this.mood,
      luck: luck ?? this.luck,
      spirituality: spirituality ?? this.spirituality,
      loveRating: loveRating ?? this.loveRating,
      moodRating: moodRating ?? this.moodRating,
      careerRating: careerRating ?? this.careerRating,
      healthRating: healthRating ?? this.healthRating,
      luckRating: luckRating ?? this.luckRating,
      luckyNumber: luckyNumber ?? this.luckyNumber,
      luckyColor: luckyColor ?? this.luckyColor,
      luckyTime: luckyTime ?? this.luckyTime,
      luckyDirection: luckyDirection ?? this.luckyDirection,
      luckyStone: luckyStone ?? this.luckyStone,
      dailyMantra: dailyMantra ?? this.dailyMantra,
      affirmation: affirmation ?? this.affirmation,
      bestActivity: bestActivity ?? this.bestActivity,
      avoidToday: avoidToday ?? this.avoidToday,
      planetaryHighlight: planetaryHighlight ?? this.planetaryHighlight,
      planetaryInfluence: planetaryInfluence ?? this.planetaryInfluence,
      tithi: tithi ?? this.tithi,
      nakshatra: nakshatra ?? this.nakshatra,
      yoga: yoga ?? this.yoga,
      karana: karana ?? this.karana,
      rahuKalam: rahuKalam ?? this.rahuKalam,
      gulikaKalam: gulikaKalam ?? this.gulikaKalam,
      yamagandaKalam: yamagandaKalam ?? this.yamagandaKalam,
      tarotCardName: tarotCardName ?? this.tarotCardName,
      tarotCardMeaning: tarotCardMeaning ?? this.tarotCardMeaning,
      tarotCardImageUrl: tarotCardImageUrl ?? this.tarotCardImageUrl,
      morningEnergy: morningEnergy ?? this.morningEnergy,
      afternoonEnergy: afternoonEnergy ?? this.afternoonEnergy,
      eveningEnergy: eveningEnergy ?? this.eveningEnergy,
      dateRange: dateRange ?? this.dateRange,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  DateTime get updatedAtOrCreated => updatedAt ?? createdAt;
}

