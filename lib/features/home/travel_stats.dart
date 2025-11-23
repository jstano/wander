class TravelStats {
  final int countriesVisited;
  final int totalCountries;
  final int continentsVisited;
  final int totalContinents;
  final int citiesVisited;
  final int placesVisited;
  final double totalMiles;
  final double milesByAir;
  final double milesByCar;
  final double milesByTrain;
  final Map<String, ContinentStats> continentBreakdown;

  TravelStats({
    required this.countriesVisited,
    this.totalCountries = 195,
    required this.continentsVisited,
    this.totalContinents = 7,
    required this.citiesVisited,
    required this.placesVisited,
    required this.totalMiles,
    required this.milesByAir,
    required this.milesByCar,
    required this.milesByTrain,
    required this.continentBreakdown,
  });

  double get countryPercentage =>
      (countriesVisited / totalCountries) * 100;

  double get continentPercentage =>
      (continentsVisited / totalContinents) * 100;
}

class ContinentStats {
  final String name;
  final int countriesVisited;
  final int totalCountries;
  final List<String> visitedCountries;

  ContinentStats({
    required this.name,
    required this.countriesVisited,
    required this.totalCountries,
    required this.visitedCountries,
  });

  double get percentage => (countriesVisited / totalCountries) * 100;
}