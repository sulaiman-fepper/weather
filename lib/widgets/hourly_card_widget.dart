import 'package:flutter/material.dart';

class HourlyCardWidget extends StatelessWidget {
  final String time;
  final String icon;
  final String temp;
  final bool isNow;
  final int isDay;
  const HourlyCardWidget({super.key, required this.time, required this.icon, required this.temp, this.isNow = false, required this.isDay});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(isNow?'assets/images/layer3.png':'assets/images/layer2.png'),
        Positioned(
          top: 25,
          left: isNow?19:14,
          child: Text(isNow?"Now":time, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: isNow?16:14),),
        ),
        Positioned(
          top: 50,
          left: 7,
          child: Image.asset('assets/images/weather_icons/$icon${isDay == 0? "-night":""}.webp', width: 55,),
        ),
        Positioned(
          top: 115,
          left: 20,
          child: Text("$temp°", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),),
        ),
      ],
    );
  }
}
