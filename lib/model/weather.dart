class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }
}

class Condition {
  final String text;

  Condition({
    required this.text,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
    );
  }
}

class Current {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final int isDay;
  final Condition condition;
  final double windKph;
  final int humidity;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: json['last_updated'],
      tempC: json['temp_c'].toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windKph: json['wind_kph'].toDouble(),
      humidity: json['humidity'],
    );
  }
}

class Forecast {
  final String date;
  final int dateEpoch;
  final Day day;
  final List<Hour> hour;

  Forecast({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.hour,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
      hour: List<Hour>.from(json['hour'].map((x) => Hour.fromJson(x))),
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;

  Day({
    required this.maxtempC,
    required this.mintempC,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c'].toDouble(),
      mintempC: json['mintemp_c'].toDouble(),
    );
  }
}

class Hour {
  final int timeEpoch;
  final String time;
  final double tempC;
  final int isDay;
  final Condition condition;

  Hour({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.isDay,
    required this.condition,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      timeEpoch: json['time_epoch'],
      time: json['time'],
      tempC: json['temp_c'].toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class WeatherData {
  final Location location;
  final Current current;
  final List<Forecast> forecast;

  WeatherData({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: List<Forecast>.from(json['forecast']['forecastday']
          .map((x) => Forecast.fromJson(x))),
    );
  }
}
