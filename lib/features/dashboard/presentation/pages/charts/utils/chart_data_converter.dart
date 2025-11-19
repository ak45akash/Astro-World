import 'package:astrology_app/features/dashboard/domain/models/chart_models.dart';
import 'package:astrology_app/features/dashboard/domain/models/astrology_chart_models.dart';

class ChartDataConverter {
  static AstrologyChartData convertToLagnaChart(ChartBundle bundle) {
    // Parse lagna sign (e.g., "Leo Lagna" -> "Leo")
    final lagnaSign = bundle.lagna.split(' ').first;
    final signNames = [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces'
    ];

    final lagnaIndex = signNames.indexOf(lagnaSign);
    final lagnaHouse = 1;

    // Create houses starting from lagna
    final houses = <HousePosition>[];
    for (int i = 0; i < 12; i++) {
      final signIndex = (lagnaIndex + i) % 12;
      final houseNumber = i + 1;
      final planetsInHouse = <String>[];

      // Find planets in this house based on degrees
      for (final planetPos in bundle.planetaryPositions) {
        final houseDegree = (planetPos.degree / 30).floor() % 12;
        if (houseDegree == i) {
          planetsInHouse.add(planetPos.planet);
        }
      }

      houses.add(HousePosition(
        houseNumber: houseNumber,
        sign: signNames[signIndex],
        planets: planetsInHouse,
        startDegree: i * 30.0,
        endDegree: (i + 1) * 30.0,
      ));
    }

    // Create planet positions
    final planets = <PlanetInHouse>[];
    for (final planetPos in bundle.planetaryPositions) {
      final houseNumber = ((planetPos.degree / 30).floor() % 12) + 1;
      final signIndex = ((planetPos.degree / 30).floor()) % 12;
      planets.add(PlanetInHouse(
        planet: planetPos.planet,
        house: houseNumber,
        sign: signNames[signIndex],
        degree: planetPos.degree,
        nakshatra: planetPos.nakshatra,
      ));
    }

    return AstrologyChartData(
      houses: houses,
      planets: planets,
      lagnaSign: lagnaSign,
      lagnaHouse: lagnaHouse,
    );
  }

  static AstrologyChartData convertToNavamshaChart(ChartBundle bundle) {
    // Parse navamsha sign (e.g., "Gemini Navamsha" -> "Gemini")
    final navamshaSign = bundle.navamsha.split(' ').first;
    final signNames = [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces'
    ];

    final navamshaIndex = signNames.indexOf(navamshaSign);

    // Create houses for navamsha chart
    final houses = <HousePosition>[];
    for (int i = 0; i < 12; i++) {
      final signIndex = (navamshaIndex + i) % 12;
      houses.add(HousePosition(
        houseNumber: i + 1,
        sign: signNames[signIndex],
        planets: [],
        startDegree: i * 30.0,
        endDegree: (i + 1) * 30.0,
      ));
    }

    // For navamsha, planets are in different positions
    final planets = <PlanetInHouse>[];
    for (final planetPos in bundle.planetaryPositions) {
      // In navamsha, planets shift by navamsha calculation
      final navamshaHouse = ((planetPos.degree / 3.33).floor() % 12) + 1;
      final signIndex = ((planetPos.degree / 3.33).floor()) % 12;
      planets.add(PlanetInHouse(
        planet: planetPos.planet,
        house: navamshaHouse,
        sign: signNames[signIndex],
        degree: planetPos.degree,
        nakshatra: planetPos.nakshatra,
      ));
    }

    return AstrologyChartData(
      houses: houses,
      planets: planets,
      lagnaSign: navamshaSign,
      lagnaHouse: 1,
    );
  }

  static AstrologyChartData convertToMoonChart(ChartBundle bundle) {
    // Parse moon sign (e.g., "Taurus Moon" -> "Taurus")
    final moonSign = bundle.moonSign.split(' ').first;
    final signNames = [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces'
    ];

    final moonIndex = signNames.indexOf(moonSign);

    // Moon chart uses moon as lagna
    final houses = <HousePosition>[];
    for (int i = 0; i < 12; i++) {
      final signIndex = (moonIndex + i) % 12;
      houses.add(HousePosition(
        houseNumber: i + 1,
        sign: signNames[signIndex],
        planets: [],
        startDegree: i * 30.0,
        endDegree: (i + 1) * 30.0,
      ));
    }

    // Find moon position
    final moonPos = bundle.planetaryPositions.firstWhere(
      (p) => p.planet == 'Moon',
      orElse: () => const PlanetPosition(
        planet: 'Moon',
        degree: 45.2,
        nakshatra: 'Rohini',
        pada: 'Pada 1',
      ),
    );

    final planets = <PlanetInHouse>[];
    for (final planetPos in bundle.planetaryPositions) {
      final relativeDegree = (planetPos.degree - moonPos.degree + 360) % 360;
      final houseNumber = (relativeDegree / 30).floor() + 1;
      final signIndex = ((planetPos.degree / 30).floor()) % 12;
      planets.add(PlanetInHouse(
        planet: planetPos.planet,
        house: houseNumber,
        sign: signNames[signIndex],
        degree: planetPos.degree,
        nakshatra: planetPos.nakshatra,
      ));
    }

    return AstrologyChartData(
      houses: houses,
      planets: planets,
      lagnaSign: moonSign,
      lagnaHouse: 1,
    );
  }

  static AstrologyChartData convertToChalitChart(ChartBundle bundle) {
    // Chalit chart is similar to Lagna but with house cusp adjustments
    // Parse lagna sign
    final lagnaSign = bundle.lagna.split(' ').first;
    final signNames = [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces'
    ];

    final lagnaIndex = signNames.indexOf(lagnaSign);

    // Parse chalit summary to get house signs
    final houseSigns = <String>[];
    for (final summary in bundle.chalitSummary) {
      final parts = summary.split(':');
      if (parts.length > 1) {
        final signPart = parts[1].split('-').first.trim();
        houseSigns.add(signPart);
      }
    }

    // Create houses with chalit adjustments
    final houses = <HousePosition>[];
    for (int i = 0; i < 12; i++) {
      final signIndex = houseSigns.length > i
          ? signNames.indexOf(houseSigns[i])
          : (lagnaIndex + i) % 12;
      final sign = signIndex >= 0
          ? signNames[signIndex]
          : signNames[(lagnaIndex + i) % 12];

      final planetsInHouse = <String>[];
      for (final planetPos in bundle.planetaryPositions) {
        final houseDegree = (planetPos.degree / 30).floor() % 12;
        if (houseDegree == i) {
          planetsInHouse.add(planetPos.planet);
        }
      }

      houses.add(HousePosition(
        houseNumber: i + 1,
        sign: sign,
        planets: planetsInHouse,
        startDegree: i * 30.0,
        endDegree: (i + 1) * 30.0,
      ));
    }

    // Create planet positions with chalit adjustments
    final planets = <PlanetInHouse>[];
    for (final planetPos in bundle.planetaryPositions) {
      final houseNumber = ((planetPos.degree / 30).floor() % 12) + 1;
      final signIndex = ((planetPos.degree / 30).floor()) % 12;
      planets.add(PlanetInHouse(
        planet: planetPos.planet,
        house: houseNumber,
        sign: signNames[signIndex],
        degree: planetPos.degree,
        nakshatra: planetPos.nakshatra,
      ));
    }

    return AstrologyChartData(
      houses: houses,
      planets: planets,
      lagnaSign: lagnaSign,
      lagnaHouse: 1,
    );
  }
}
