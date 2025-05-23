import 'package:weather_demo/core/models/forecast_entities.dart';
import 'package:weather_demo/core/service/weather_service.dart';

class WeatherRepository {
  //Viet truyen tu ngoai truyen vao de sau nay viet Unit test
  final WeatherApiService _service;

  WeatherRepository(this._service);

  Future<WeatherData> getCurrentWeather(String city) async {
    return _service.getCurrentWeather(city);
  }

  Future<WeatherForecast> getForecast(String city, {int days = 5}) async {
    final res = await _service.getForecast(city, days: days);
    return res;
  }
}
