import 'package:dartz/dartz.dart';
import 'package:open_weather/src/core/errors/failure.dart';
import 'package:open_weather/src/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}