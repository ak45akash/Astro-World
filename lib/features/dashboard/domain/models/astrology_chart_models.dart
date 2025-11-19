class HousePosition {
  final int houseNumber;
  final String sign;
  final List<String> planets;
  final double startDegree;
  final double endDegree;

  const HousePosition({
    required this.houseNumber,
    required this.sign,
    required this.planets,
    required this.startDegree,
    required this.endDegree,
  });
}

class PlanetInHouse {
  final String planet;
  final int house;
  final String sign;
  final double degree;
  final String nakshatra;

  const PlanetInHouse({
    required this.planet,
    required this.house,
    required this.sign,
    required this.degree,
    required this.nakshatra,
  });
}

class AstrologyChartData {
  final List<HousePosition> houses;
  final List<PlanetInHouse> planets;
  final String lagnaSign;
  final int lagnaHouse;

  const AstrologyChartData({
    required this.houses,
    required this.planets,
    required this.lagnaSign,
    required this.lagnaHouse,
  });
}
