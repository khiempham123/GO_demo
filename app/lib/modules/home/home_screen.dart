import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_demo/modules/base/base_state.dart';
import 'package:weather_demo/modules/home/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeModel, HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE8E9F3),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
            ),
            child: Text(
              'Weather Dashboard',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: super.buildContent()),
        ],
      ),
    );
  }

  @override
  Widget buildContentView(BuildContext context, HomeModel model) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isLargeScreen ? 40 : 20),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child:
                  isLargeScreen
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left sidebar
                          SizedBox(width: 300, child: _buildSearchBar(model)),
                          const SizedBox(width: 40),
                          // Right content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildCurrentWeather(model),
                                const SizedBox(height: 32),
                                _buildForecast(model),
                              ],
                            ),
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          _buildSearchBar(model),
                          const SizedBox(height: 24),
                          _buildCurrentWeather(model),
                          const SizedBox(height: 24),
                          _buildForecast(model),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(HomeModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Enter a City Name',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'E.g., New York, London, Tokyo',
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF6366F1)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              FocusScope.of(context).unfocus();
              model.loadCurrentWeather(controller.text);
              model.loadForecast(controller.text);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6366F1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Search',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'or',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Handle current location
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6B7280),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Use Current Location',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentWeather(HomeModel model) {
    if (model.currentWeather == null) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              Icons.location_off,
              size: 64,
              color: Colors.white.withOpacity(0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'No Location Selected',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please search for a city to see weather information',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Determine icon based on temperature and humidity
    IconData weatherIcon;
    double temp = model.currentWeather?.main?.temp ?? 0;
    int humidity = model.currentWeather?.main?.humidity ?? 0;

    if (temp > 30) {
      weatherIcon = Icons.wb_sunny; // Hot weather
    } else if (temp > 20) {
      weatherIcon = Icons.cloud; // Mild weather
    } else {
      weatherIcon = Icons.ac_unit; // Cold weather
    }

    if (humidity > 70) {
      weatherIcon = Icons.water_drop; // High humidity
    }

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.forecast?.city?.name ?? 'Unknown City'} (${DateFormat('yyyy-MM-dd').format(DateTime.now())})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Temperature: ${temp}°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Wind: ${model.currentWeather?.wind?.speed ?? "N/A"} M/S',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Humidity: ${humidity}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(weatherIcon, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Weather Icon',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForecast(HomeModel model) {
    final items = model.forecast?.list ?? [];
    if (items.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4-Day Forecast',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(Icons.cloud_off, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No forecast data available',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '4-Day Forecast',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length > 4 ? 4 : items.length,
          itemBuilder: (context, index) {
            final forecast = items[index];
            final temp = forecast.main?.temp ?? 0;
            final humidity = forecast.main?.humidity ?? 0;

            // Determine icon based on temperature and humidity
            IconData weatherIcon;
            if (temp > 30) {
              weatherIcon = Icons.wb_sunny; // Hot weather
            } else if (temp > 20) {
              weatherIcon = Icons.cloud; // Mild weather
            } else {
              weatherIcon = Icons.ac_unit; // Cold weather
            }
            if (humidity > 70) {
              weatherIcon = Icons.water_drop; // High humidity
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6B7280),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(weatherIcon, size: 48, color: Colors.white),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat(
                            'EEEE, MMM d',
                          ).format(DateTime.parse(forecast.dtTxt!)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Temp: ${temp}°C, Humidity: ${humidity}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildForecastCard(dynamic forecast) {
    final date = DateTime.parse(forecast.dtTxt!);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF6B7280),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '(${DateFormat('yyyy-MM-dd').format(date)})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Icon(
            Icons.wb_sunny, // Forecast weather icon
            size: 32,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            'Temp: ${forecast.main?.temp ?? "N/A"}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Wind: ${forecast.wind?.speed ?? "N/A"} M/S',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Humidity: ${forecast.main?.humidity ?? "N/A"}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeModel createModel() {
    return HomeModel();
  }

  @override
  bool get wantKeepAlive => true;
}
