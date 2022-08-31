import 'dart:convert';
import 'package:open_weather/src/core/errors/exception.dart';
import 'package:open_weather/src/core/utils/api_utils.dart';
import 'package:open_weather/src/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  const RemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await client.get(
      Uri.parse(
        ApiUrls.currentWeatherByName(cityName),
      ),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
