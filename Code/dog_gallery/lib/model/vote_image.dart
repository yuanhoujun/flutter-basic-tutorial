import 'package:json_annotation/json_annotation.dart';

import 'dog_image.dart';

part 'vote_image.g.dart';

@JsonSerializable(explicitToJson: true)
class VoteImage {
  final int id;
  final DogImage image;
  final int value;

  VoteImage({
    required this.id,
    required this.image,
    required this.value,
  });

  factory VoteImage.fromJson(Map<String, dynamic> json) =>
      _$VoteImageFromJson(json);

  Map<String, dynamic> toJson() => _$VoteImageToJson(this);
}
