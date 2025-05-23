import 'package:weather_demo/app_dependencies/app_dependencies.dart';
import 'package:weather_demo/core/models/forecast_entities.dart';
import 'package:weather_demo/core/repository/weather_repository.dart';
import 'package:weather_demo/modules/base/base_model.dart';

class HomeModel extends BaseModel {
  @override
  ViewState get initState => ViewState.loaded;

  final repo = locator.get<WeatherRepository>();

  WeatherData? _currentWeather;
  WeatherData? get currentWeather => _currentWeather;

  WeatherForecast? _forecast;
  WeatherForecast? get forecast => _forecast;

  Future<void> loadCurrentWeather(String city) async {
    _currentWeather = await getCurrentWeather(city);
    notifyListeners();
  }

  Future<WeatherData?> getCurrentWeather(String city) async {
    return await doTask<WeatherData>(
      doSomething: () async {
        return await repo.getCurrentWeather(city);
      },
    );
  }

  Future<void> loadForecast(String city, {int days = 5}) async {
    _forecast = await getForecast(city, days: days);
    loadCurrentWeather(city);
    notifyListeners();
  }

  Future<WeatherForecast?> getForecast(String city, {int days = 5}) async {
    return await doTask<WeatherForecast>(
      doSomething: () async {
        return await repo.getForecast(city, days: days);
      },
    );
  }
}
