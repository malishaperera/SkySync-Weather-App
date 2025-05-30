import 'package:flutter/material.dart';
import 'package:simple_weather_app/costants.dart';
import 'package:simple_weather_app/weather/openweather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final openWeatherApi = const OpenWeatherAPI(OPEN_WEATHER_API_KEY);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: openWeatherApi.getWeatherDetails(lat: 6.0329, lon: 80.2168),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const CircularProgressIndicator();
              else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              var data = snapshot.data;

              if (data == null) return const Text("No data found");

              return Column(
                children: [
                  const SizedBox(height: 50),
                  Image.network(
                    openWeatherApi.getWeatherIcon(data['weather'][0]['icon']),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['main']['temp'].toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),

                      const Text("°C"),
                    ],
                  ),
                  Text(data['name'], style: const TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.thermometerLow),
                      Column(
                        children: [
                          Text(
                            "${data['main']['temp_min']}°C",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Icon(MdiIcons.thermometerHigh),
                      Column(
                        children: [
                          Text(
                            "${data['main']['temp_max']}°C",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Icon(MdiIcons.waterPercent),
                      Column(
                        children: [
                          Text(
                            "${data['main']['humidity']}%",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );

              // return Text("hi");
            },
          ),
        ),
      ),
    );
  }
}
