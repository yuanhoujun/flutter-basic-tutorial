import 'package:dog_gallery/model/dog_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'breed.g.dart';

@JsonSerializable(explicitToJson: true)
class Breed {
  final int id;
  final String name;
  @JsonKey(name: "bred_for")
  final String? bredFor;
  final String? temperament;
  @JsonKey(name: "life_span")
  final String lifeSpan;
  final DogImage image;

  const Breed(
      {required this.id,
      required this.name,
      required this.bredFor,
      required this.temperament,
      required this.lifeSpan,
      required this.image});

  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);

  Map<String, dynamic> toJson() => _$BreedToJson(this);
}
