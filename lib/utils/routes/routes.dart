

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:weather/main.dart';
import 'package:weather/utils/routes/routes_name.dart';
import 'package:weather/view/location_selection_screen.dart';

import '../../view/weather_display_screen.dart';



class Routes {

  static var list = [
    GetPage(
      name: RoutesName.login,
      page: () => LocationDisplayScreen(),
    ),
    GetPage(
      name: RoutesName.courses,
      page: () => WeatherDisplayScreen(),
    ),
  ];
}