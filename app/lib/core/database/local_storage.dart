import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_demo/core/models/forecast_entities.dart';

class LocalStorage {
  static const String _weatherHistoryKey = 'weather_history';

  // Lưu thông tin thời tiết vào lịch sử
  Future<void> saveWeatherToHistory(WeatherForecast weather) async {
    final prefs = await SharedPreferences.getInstance();
    final currentHistory = await getWeatherHistory();

    // Kiểm tra xem thành phố đã có trong lịch sử chưa
    final existingIndex = currentHistory.indexWhere(
      (item) =>
          item.city?.name == weather.city?.name &&
          item.city?.country == weather.city?.country,
    );

    if (existingIndex >= 0) {
      currentHistory.removeAt(existingIndex);
    }

    // Thêm vào đầu danh sách
    currentHistory.insert(0, weather);

    // Giới hạn lịch sử 10 thành phố
    if (currentHistory.length > 10) {
      currentHistory.removeLast();
    }

    // Lưu lại vào SharedPreferences
    final historyJson =
        currentHistory.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList(_weatherHistoryKey, historyJson);
  }

  // Lấy lịch sử thời tiết
  Future<List<WeatherForecast>> getWeatherHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_weatherHistoryKey) ?? [];

    // Chỉ lấy lịch sử trong ngày hiện tại

    return historyJson.map((jsonString) {
      final data = jsonDecode(jsonString);
      return WeatherForecast.fromJson(data);
    }).toList();
  }

  // Xóa toàn bộ lịch sử
  Future<void> clearWeatherHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_weatherHistoryKey);
  }
}
