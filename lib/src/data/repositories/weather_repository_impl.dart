import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:open_weather/src/core/errors/exception.dart';
import 'package:open_weather/src/core/errors/failure.dart';
import 'package:open_weather/src/data/datasources/remote_data_source.dart';
import 'package:open_weather/src/domain/entities/weather.dart';
import 'package:open_weather/src/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;
  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }
}
