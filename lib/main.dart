import 'package:flutter/material.dart';
import 'package:simple_weather_app/costants.dart';
import 'package:simple_weather_app/weather/openweather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final openWeatherApi = const OpenWeatherAPI(OPEN_WEATHER_API_KEY);

  void initState() {
    var res = openWeatherApi.getWeatherDetails(lat: 37.7749, lon: -122.4194);
    res.then((value) {
      print("Weather details: $value");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: openWeatherApi.getWeatherDetails(
              lat: 37.7749,
              lon: -122.4194,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const CircularProgressIndicator();
              else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                var data = snapshot.data;
                return Text(data!['weather'][0]['main'].toString());
              }
              // return Text("hi");
            },
          ),
        ),
      ),
    );
  }
}
