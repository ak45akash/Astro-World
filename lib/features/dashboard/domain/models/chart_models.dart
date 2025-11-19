class VarshfalPeriod {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String focus;

  const VarshfalPeriod({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.focus,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'focus': focus,
      };

  factory VarshfalPeriod.fromJson(Map<String, dynamic> json) => VarshfalPeriod(
        title: json['title'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
        focus: json['focus'] as String,
      );
}

class PlanetPosition {
  final String planet;
  final double degree;
  final String nakshatra;
  final String pada;

  const PlanetPosition({
    required this.planet,
    required this.degree,
    required this.nakshatra,
    required this.pada,
  });

  Map<String, dynamic> toJson() => {
        'planet': planet,
        'degree': degree,
        'nakshatra': nakshatra,
        'pada': pada,
      };

  factory PlanetPosition.fromJson(Map<String, dynamic> json) => PlanetPosition(
        planet: json['planet'] as String,
        degree: (json['degree'] as num).toDouble(),
        nakshatra: json['nakshatra'] as String,
        pada: json['pada'] as String,
      );
}

class DashaPeriod {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String ruler;

  const DashaPeriod({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.ruler,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'ruler': ruler,
      };

  factory DashaPeriod.fromJson(Map<String, dynamic> json) => DashaPeriod(
        name: json['name'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
        ruler: json['ruler'] as String,
      );
}

class ChartBundle {
  final DateTime generatedAt;
  final DateTime nextRefreshAt;
  final List<VarshfalPeriod> varshfal;
  final List<PlanetPosition> planetaryPositions;
  final List<DashaPeriod> dashaTimeline;
  final String lagna;
  final String navamsha;
  final String moonSign;
  final List<String> chalitSummary;

  const ChartBundle({
    required this.generatedAt,
    required this.nextRefreshAt,
    required this.varshfal,
    required this.planetaryPositions,
    required this.dashaTimeline,
    required this.lagna,
    required this.navamsha,
    required this.moonSign,
    required this.chalitSummary,
  });

  Map<String, dynamic> toJson() => {
        'generatedAt': generatedAt.toIso8601String(),
        'nextRefreshAt': nextRefreshAt.toIso8601String(),
        'varshfal': varshfal.map((e) => e.toJson()).toList(),
        'planetaryPositions':
            planetaryPositions.map((e) => e.toJson()).toList(),
        'dashaTimeline': dashaTimeline.map((e) => e.toJson()).toList(),
        'lagna': lagna,
        'navamsha': navamsha,
        'moonSign': moonSign,
        'chalitSummary': chalitSummary,
      };

  factory ChartBundle.fromJson(Map<String, dynamic> json) => ChartBundle(
        generatedAt: DateTime.parse(json['generatedAt'] as String),
        nextRefreshAt: DateTime.parse(json['nextRefreshAt'] as String),
        varshfal: (json['varshfal'] as List<dynamic>)
            .map((e) => VarshfalPeriod.fromJson(e as Map<String, dynamic>))
            .toList(),
        planetaryPositions: (json['planetaryPositions'] as List<dynamic>)
            .map((e) => PlanetPosition.fromJson(e as Map<String, dynamic>))
            .toList(),
        dashaTimeline: (json['dashaTimeline'] as List<dynamic>)
            .map((e) => DashaPeriod.fromJson(e as Map<String, dynamic>))
            .toList(),
        lagna: json['lagna'] as String,
        navamsha: json['navamsha'] as String,
        moonSign: json['moonSign'] as String,
        chalitSummary: (json['chalitSummary'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
      );
}
