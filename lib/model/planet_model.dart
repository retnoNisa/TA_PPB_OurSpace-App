import 'dart:convert';

class PlanetModel {
  int planetOrder;
  String name;
  String description;
  BasicDetails basicDetails;
  String source;
  String wikiLink;
  ImgSrc imgSrc;
  int id;
  bool isFavorite = false;

  PlanetModel({
    required this.planetOrder,
    required this.name,
    required this.description,
    required this.basicDetails,
    required this.source,
    required this.wikiLink,
    required this.imgSrc,
    required this.id,
  });

  factory PlanetModel.fromRawJson(String str) =>
      PlanetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlanetModel.fromJson(Map<String, dynamic> json) => PlanetModel(
        planetOrder: json["planetOrder"],
        name: json["name"],
        description: json["description"],
        basicDetails: BasicDetails.fromJson(json["basicDetails"]),
        source: json["source"],
        wikiLink: json["wikiLink"],
        imgSrc: ImgSrc.fromJson(json["imgSrc"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "planetOrder": planetOrder,
        "name": name,
        "description": description,
        "basicDetails": basicDetails.toJson(),
        "source": source,
        "wikiLink": wikiLink,
        "imgSrc": imgSrc.toJson(),
        "id": id,
      };
}

class BasicDetails {
  String volume;
  String mass;

  BasicDetails({
    required this.volume,
    required this.mass,
  });

  factory BasicDetails.fromRawJson(String str) =>
      BasicDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BasicDetails.fromJson(Map<String, dynamic> json) => BasicDetails(
        volume: json["volume"],
        mass: json["mass"],
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "mass": mass,
      };
}

class ImgSrc {
  String img;
  String imgDescription;

  ImgSrc({
    required this.img,
    required this.imgDescription,
  });

  factory ImgSrc.fromRawJson(String str) => ImgSrc.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImgSrc.fromJson(Map<String, dynamic> json) => ImgSrc(
        img: json["img"],
        imgDescription: json["imgDescription"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "imgDescription": imgDescription,
      };
}
