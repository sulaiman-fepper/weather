class Location {
  final String id;
  final String name;
  final String country;
  final String admin1;
  final double lat;
  final double lon;
  final int population;

  Location({
    required this.id,
    required this.name,
    required this.country,
    required this.admin1,
    required this.lat,
    required this.lon,
    required this.population,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      admin1: json['admin1'] as String,
      lat: double.parse(json['lat'] as String),
      lon: double.parse(json['lon'] as String),
      population: int.parse(json['pop'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'admin1': admin1,
      'lat': lat.toString(),
      'lon': lon.toString(),
      'pop': population.toString(),
    };
  }

  @override
  String toString() {
    return 'Location(id: $id, name: $name, country: $country, admin1: $admin1, lat: $lat, lon: $lon, population: $population)';
  }
}