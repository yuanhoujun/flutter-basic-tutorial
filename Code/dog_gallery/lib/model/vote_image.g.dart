// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteImage _$VoteImageFromJson(Map<String, dynamic> json) => VoteImage(
      id: json['id'] as int,
      image: DogImage.fromJson(json['image'] as Map<String, dynamic>),
      value: json['value'] as int,
    );

Map<String, dynamic> _$VoteImageToJson(VoteImage instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image.toJson(),
      'value': instance.value,
    };
