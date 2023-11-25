import 'package:flutter/foundation.dart';
import '../model/favorite_model.dart';
import '../model/helper/db_helper.dart';
import '../utils/state/my_state.dart';

class DbProvider extends ChangeNotifier {
  List<FavoriteModel> _favoriteModels = [];
  late DbHelper _dbHelper;
  MyState myState = MyState.loading;

  List<FavoriteModel> get favoriteModels => _favoriteModels;
  int get favoriteLength => _favoriteModels.length;

  DbProvider() {
    _dbHelper = DbHelper();
    getAllFavorite();
  }

  void getAllFavorite() async {
    try {
      myState = MyState.loading;
      notifyListeners();

      _favoriteModels = await _dbHelper.getFavorite();

      myState = MyState.success;
      notifyListeners();
    } catch (e) {
      myState = MyState.failed;
      notifyListeners();
    }
  }

  Future<void> addFavorite(FavoriteModel favModel) async {
    await _dbHelper.insertFavorite(favModel);
    getAllFavorite();
  }

  Future<void> deleteFavorite(int idPlanet) async {
    await _dbHelper.deleteFavorite(idPlanet);
    getAllFavorite();
  }
}
