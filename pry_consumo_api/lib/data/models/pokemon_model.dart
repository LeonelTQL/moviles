import '../../domain/entities/pokemon.dart';


class PokemonModel extends Pokemon{
  PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json){
    final url = json["url"];
    final parts = url.split("/");
    final id = int.parse(parts[parts.length - 2]);
    final imgUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";

    return PokemonModel(
        id: id,
        name: json["name"],
        imageUrl: imgUrl);
  }

}