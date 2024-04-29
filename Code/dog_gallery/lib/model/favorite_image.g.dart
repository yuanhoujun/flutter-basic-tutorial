// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteImage _$FavoriteImageFromJson(Map<String, dynamic> json) =>
    FavoriteImage(
      id: json['id'] as int,
      image: DogImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteImageToJson(FavoriteImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image.toJson(),
    };
