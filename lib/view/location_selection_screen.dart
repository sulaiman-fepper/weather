import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/utils/routes/routes_name.dart';

import '../model/weather.dart';
import '../view_model/weather_view_model.dart';

class LocationDisplayScreen extends StatefulWidget {
  LocationDisplayScreen({super.key});
  @override
  State<LocationDisplayScreen> createState() => _LocationDisplayScreenState();
}

class _LocationDisplayScreenState extends State<LocationDisplayScreen> {


  TextEditingController searchParams = TextEditingController(); // Email controller


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1B33),
        elevation: 0,
        title: Text("Weather", style: TextStyle(color: Colors.white),),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E3358), // #2E3358
              Color(0xFF1C1B33), // #1C1B33
            ],
            stops: [0.0283, 0.9485],
            transform: GradientRotation(169.61 * 3.141592 / 180),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: searchParams,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                  filled: true,
                  fillColor: Color.fromRGBO(46, 51, 90, 0.26),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search for a city',
                  prefixIcon: Icon(Icons.search, color: Color.fromRGBO(235, 235, 245, 0.6)),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(235, 235, 245, 0.6),
                  ),
                ),
                onChanged: (val){
                  setState(() {});
                },
                style: TextStyle(
                  color: Color.fromRGBO(235, 235, 245, 0.6),
                ),
              ),
            ),
            Consumer<WeatherViewModel>(
              builder: (context, value, child) {
                return FutureBuilder(
                  future: value.fetchCities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      // Data is successfully fetched, you can access it via snapshot.data
                      List cities = snapshot.data!;
                      // Now you can use the data to build your UI, for example:
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.8, // Set height based on available height
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cities.length,
                          itemBuilder: (context, index) {
                            return cities[index]['name'].toString().toLowerCase().contains(searchParams.text.toLowerCase())?ListTile(
                              title: Text(cities[index]['name'], style: TextStyle(color: Colors.white)),
                              subtitle: Text(cities[index]['state']),
                              onTap: (){
                                value.location = "${cities[index]['name']},${cities[index]['state']}";
                                value.notifyListeners();
                                Navigator.pushNamed(context, RoutesName.courses);
                              },
                              // You can display other information as well based on your requirement
                            ):Container();
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
