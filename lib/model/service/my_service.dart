import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:our_space/utils/constant/api_key.dart';
import '../astro_model.dart';
import '../planet_model.dart';

class MyService {
  final Dio dio = Dio();
  DateTime date = DateTime.now();

  Future<List<PlanetModel>> fetchPlanet() async {
    try {
      List<PlanetModel> listPlanet = [];
      final response = await dio.get(
        'https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planets/',
        options: Options(
          headers: {'X-RapidAPI-Key': ApiKey.keyPlanet},
        ),
      );

      for (var element in response.data) {
        listPlanet.add(PlanetModel.fromJson(element));
      }
      return listPlanet;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<AstroModel> fetchAstroDay() async {
    try {
      final response = await dio.get(
        'https://api.nasa.gov/planetary/apod?api_key=${ApiKey.keyAstro}&date=${DateFormat('yyy-MM-dd').format(date)}',
      );

      return AstroModel.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
