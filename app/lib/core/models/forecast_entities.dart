// weather_forecast_model.dart

import 'dart:convert';

class WeatherForecast {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<WeatherData>? list;
  final City? city;

  WeatherForecast({this.cod, this.message, this.cnt, this.list, this.city});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      WeatherForecast(
        cod: json['cod'],
        message: json['message'],
        cnt: json['cnt'],
        list:
            json['list'] != null
                ? List<WeatherData>.from(
                  json['list'].map((x) => WeatherData.fromJson(x)),
                )
                : null,
        city: json['city'] != null ? City.fromJson(json['city']) : null,
      );

  Map<String, dynamic> toJson() => {
    'cod': cod,
    'message': message,
    'cnt': cnt,
    'list':
        list != null ? List<dynamic>.from(list!.map((x) => x.toJson())) : null,
    'city': city?.toJson(),
  };

  static WeatherForecast fromRawJson(String str) =>
      WeatherForecast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class WeatherData {
  final int? dt;
  final MainWeather? main;
  final List<Weather>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Rain? rain;
  final Sys? sys;
  final String? dtTxt;

  WeatherData({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    dt: json['dt'],
    main: json['main'] != null ? MainWeather.fromJson(json['main']) : null,
    weather:
        json['weather'] != null
            ? List<Weather>.from(
              json['weather'].map((x) => Weather.fromJson(x)),
            )
            : null,
    clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
    wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
    visibility: json['visibility'],
    pop: json['pop']?.toDouble(),
    rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
    sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
    dtTxt: json['dt_txt'],
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'main': main?.toJson(),
    'weather':
        weather != null
            ? List<dynamic>.from(weather!.map((x) => x.toJson()))
            : null,
    'clouds': clouds?.toJson(),
    'wind': wind?.toJson(),
    'visibility': visibility,
    'pop': pop,
    'rain': rain?.toJson(),
    'sys': sys?.toJson(),
    'dt_txt': dtTxt,
  };
}

class MainWeather {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final double? tempKf;

  MainWeather({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) => MainWeather(
    temp: json['temp']?.toDouble(),
    feelsLike: json['feels_like']?.toDouble(),
    tempMin: json['temp_min']?.toDouble(),
    tempMax: json['temp_max']?.toDouble(),
    pressure: json['pressure'],
    seaLevel: json['sea_level'],
    grndLevel: json['grnd_level'],
    humidity: json['humidity'],
    tempKf: json['temp_kf']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
    'humidity': humidity,
    'temp_kf': tempKf,
  };
}

class Weather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json['id'],
    main: json['main'],
    description: json['description'],
    icon: json['icon'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}

class Clouds {
  final int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) =>
      Clouds(all: json['all']);

  Map<String, dynamic> toJson() => {'all': all};
}

class Wind {
  final double? speed;
  final int? deg;
  final double? gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json['speed']?.toDouble(),
    deg: json['deg'],
    gust: json['gust']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};
}

class Rain {
  final double? threeHour;

  Rain({this.threeHour});

  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(threeHour: json['3h']?.toDouble());

  Map<String, dynamic> toJson() => {'3h': threeHour};
}

class Sys {
  final String? pod;

  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(pod: json['pod']);

  Map<String, dynamic> toJson() => {'pod': pod};
}

class City {
  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['id'],
    name: json['name'],
    coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
    country: json['country'],
    population: json['population'],
    timezone: json['timezone'],
    sunrise: json['sunrise'],
    sunset: json['sunset'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'coord': coord?.toJson(),
    'country': country,
    'population': population,
    'timezone': timezone,
    'sunrise': sunrise,
    'sunset': sunset,
  };
}

class Coord {
  final double? lat;
  final double? lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) =>
      Coord(lat: json['lat']?.toDouble(), lon: json['lon']?.toDouble());

  Map<String, dynamic> toJson() => {'lat': lat, 'lon': lon};
}
