import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/utils/custom_style.dart';
import '../view_model/weather_view_model.dart';
import '../widgets/hourly_card_widget.dart';

class WeatherDisplayScreen extends StatelessWidget {
  const WeatherDisplayScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _buildBottomSheet(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(width: 0.9, color: Colors.white),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0821, 0.7043],
          colors: [
            const Color(0xFF2E335A).withOpacity(0.2),
            const Color(0xFF1C1B33).withOpacity(0.99),
          ],
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Consumer<WeatherViewModel>(
          builder: (context, value, child) {
            return FutureBuilder<List<Hour>>(
              future: value.fetchWeatherHour(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return _buildHourlyForecast(snapshot.data, value);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHourlyForecast(List<Hour>? hourlyForecast, WeatherViewModel value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 15,),
        Text("Hourly Forecast", style: CustomStyle.bottomHeaderStyle,),
        const SizedBox(height: 15,),
        const Divider(thickness: 0, height: 0,),
        const SizedBox(height: 15,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: hourlyForecast?.map((hourly) {
              return HourlyCardWidget(
                time: hourly.time.split(" ").last,
                icon: hourly.condition.text.replaceAll(' ', '').toLowerCase(),
                temp: hourly.tempC.toString(),
                isNow: int.parse(hourly.time.split(" ").last.split(":").first) == int.parse(value.weather!.location.localtime.split(" ").last.split(":").first), // You need to decide how to determine if it's "now"
                isDay: hourly.isDay,
              );
            }).toList() ?? [],
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SafeArea(
          child: Consumer<WeatherViewModel>(
            builder: (context, value, child) {
              return FutureBuilder<WeatherData>(
                future: value.fetchWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return _buildWeatherDisplay(snapshot.data);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDisplay(WeatherData? weatherData) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        Text(weatherData?.location.name ?? '', style: CustomStyle.headerStyle,),
        Text("${weatherData?.current.tempC}°", style: CustomStyle.headerTempStyle,),
        Text(weatherData?.current.condition.text ?? '', style: CustomStyle.offWhiteStyle,),
        Text("H:${weatherData?.forecast[0].day.maxtempC}°    L:${weatherData?.forecast[0].day.mintempC}°", style: CustomStyle.whiteStyle),
        Text("Wind: ${weatherData?.current.windKph} KPH", style: CustomStyle.offWhiteStyle,),
        Text("Humidity: ${weatherData?.current.humidity} %", style: CustomStyle.offWhiteStyle,),
        Image.asset("assets/images/front.png"),
      ],
    );
  }
}
