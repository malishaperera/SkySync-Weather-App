import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenWeatherAPI {
  final String apiKey;

  const OpenWeatherAPI(this.apiKey);

  Future<Map> getWeatherDetails({
    required double lat,
    required double lon,
  }) async {
    print("Getting weather details...");

    var url =
        // "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude={part}&appid=$apiKey";
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";

    var res = await http.get(Uri.parse(url));

    print("Running getWeatherDetails...$res");
    print(res.body);

    return jsonDecode(res.body);
  }
}
