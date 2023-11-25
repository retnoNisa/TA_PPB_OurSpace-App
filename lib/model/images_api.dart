import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NasaApi {
  final Dio _dio = Dio();

  Future<Response> fetchNasaImages({required String query}) async {
    final url = 'https://images-api.nasa.gov/search?q=$query&page_size=10';

    try {
      final response = await _dio.get(url);
      debugPrint(response.toString());
      return response;
    } catch (error) {
      throw Exception('Failed to fetch NASA images: $error');
    }
  }
}
