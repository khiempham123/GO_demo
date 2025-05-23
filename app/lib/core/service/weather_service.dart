import 'package:weather_demo/core/models/forecast_entities.dart';
import '../http_client/http_client.dart';

class WeatherApiService {
  final String baseUrl =
      'http://127.0.0.1:5001/myproject-112f3/us-central1/weatherProxy';
  final HttpClient http;

  WeatherApiService({required this.http});

  Future<WeatherData> getCurrentWeather(String city) async {
    final url = '$baseUrl?q=$city&type=current';
    final response = await http.dio.get(url);

    if (response.statusCode == 200) {
      return WeatherData.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }

  Future<WeatherForecast> getForecast(String city, {int days = 5}) async {
    final url = '$baseUrl?q=$city&type=forecast&cnt=${days * 8}';
    final response = await http.dio.get(url);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(response.data);
    } else {
      throw Exception('Failed to load forecast data: ${response.statusCode}');
    }
  }
}
