// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Breed _$BreedFromJson(Map<String, dynamic> json) => Breed(
      id: json['id'] as int,
      name: json['name'] as String,
      bredFor: json['bred_for'] as String?,
      temperament: json['temperament'] as String?,
      lifeSpan: json['life_span'] as String,
      image: DogImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BreedToJson(Breed instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bred_for': instance.bredFor,
      'temperament': instance.temperament,
      'life_span': instance.lifeSpan,
      'image': instance.image.toJson(),
    };
