class Character {
  final int id;
  final String name;
  final String ki;
  final String maxKi;
  final String race;
  final String gender;
  final String description;
  final String image;
  final String affiliation;
  final OriginPlanet? originPlanet;
  final List<Transformation>? transformations;

  Character({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    this.originPlanet,
    this.transformations,
  });
}

class OriginPlanet {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;

  OriginPlanet({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
  });
}

class Transformation {
  final int id;
  final String name;
  final String image;
  final String ki;

  Transformation({
    required this.id,
    required this.name,
    required this.image,
    required this.ki,
  });
}
