import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/network/NetworkApiService.dart';
import '../model/weather.dart';
import '../res/app_url.dart';

class WeatherViewModel with ChangeNotifier {
  WeatherData? weather;

  String location = "";
  Future<List<Hour>> fetchWeatherHour() async {
    print(location);
    print(AppUrl.baseUrl+location);
    var rawData = await NetworkApiService().getGetApiResponse(AppUrl.baseUrl+location);
    weather = WeatherData.fromJson(rawData);
    List<Hour> hour = weather!.forecast[0].hour;
    return hour;
  }

  Future<WeatherData> fetchWeather() async {
    var rawData = await NetworkApiService().getGetApiResponse(AppUrl.baseUrl+location);
    WeatherData weather = WeatherData.fromJson(rawData);
    return weather;
  }


  Future fetchCities() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/cities.json');
      final data = jsonDecode(jsonString);
      return data;
    } catch (e) {
      print('Error fetching cities: $e');
      return []; // Return an empty list in case of any error
    }
  }

}