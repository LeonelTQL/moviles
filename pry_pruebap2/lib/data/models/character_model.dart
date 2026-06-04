import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required super.id,
    required super.name,
    required super.ki,
    required super.maxKi,
    required super.race,
    required super.gender,
    required super.description,
    required super.image,
    required super.affiliation,
    super.originPlanet,
    super.transformations,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      ki: json['ki'],
      maxKi: json['maxKi'],
      race: json['race'],
      gender: json['gender'],
      description: json['description'],
      image: json['image'],
      affiliation: json['affiliation'],
      originPlanet: json['originPlanet'] != null
          ? OriginPlanetModel.fromJson(json['originPlanet'])
          : null,
      transformations: json['transformations'] != null
          ? (json['transformations'] as List)
              .map((t) => TransformationModel.fromJson(t))
              .toList()
          : null,
    );
  }
}

class OriginPlanetModel extends OriginPlanet {
  OriginPlanetModel({
    required super.id,
    required super.name,
    required super.isDestroyed,
    required super.description,
    required super.image,
  });

  factory OriginPlanetModel.fromJson(Map<String, dynamic> json) {
    return OriginPlanetModel(
      id: json['id'],
      name: json['name'],
      isDestroyed: json['isDestroyed'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class TransformationModel extends Transformation {
  TransformationModel({
    required super.id,
    required super.name,
    required super.image,
    required super.ki,
  });

  factory TransformationModel.fromJson(Map<String, dynamic> json) {
    return TransformationModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      ki: json['ki'],
    );
  }
}
