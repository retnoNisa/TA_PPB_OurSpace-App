class FavoriteModel {
  String? planetImg;
  String? name;
  int? id;
  int? idPlanet;

  FavoriteModel({
    this.planetImg,
    this.name,
    this.id,
    this.idPlanet,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'planetImg': planetImg,
      'id': id,
      'idPlanet': idPlanet,
    };
  }

  FavoriteModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    planetImg = map['planetImg'];
    id = map['id'];
    idPlanet = map['idPlanet'];
  }
}
