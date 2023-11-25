import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/astro_model.dart';
import '../model/service/my_service.dart';
import '../utils/state/my_state.dart';

class AstroProvider extends ChangeNotifier {
  final MyService service = MyService();

  AstroModel? astroDay;

  MyState myState = MyState.loading;

  Future fetchAstroDay() async {
    try {
      myState = MyState.loading;
      notifyListeners();

      astroDay = await service.fetchAstroDay();

      myState = MyState.success;
      notifyListeners();
    } catch (e) {
      if (e is DioError) {
        e.response?.statusCode;
      }

      myState = MyState.failed;
      notifyListeners();
    }
  }
}
