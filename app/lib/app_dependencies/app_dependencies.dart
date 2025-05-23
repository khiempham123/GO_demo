import 'package:get_it/get_it.dart';
import 'package:weather_demo/core/database/local_storage.dart';
import 'package:weather_demo/core/repository/weather_repository.dart';
import 'package:weather_demo/core/service/weather_service.dart';
import 'package:weather_demo/core/http_client/http_client.dart';

final locator = GetIt.instance;

class AppDependencies {
  static void initial() {
    //Dang ky keep alive xuyen suot app
    locator.registerLazySingleton(() => HttpClient());
    locator.registerLazySingleton(() => WeatherApiService(http: locator()));
    locator.registerLazySingleton(() => WeatherRepository(locator()));
    locator.registerLazySingleton(() => LocalStorage());
  }
}
