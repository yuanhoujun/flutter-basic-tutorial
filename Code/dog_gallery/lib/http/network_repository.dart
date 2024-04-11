import 'package:dio/dio.dart';
import 'package:dog_gallery/model/api.dart';

import '../model/breed.dart';
import '../model/dog_image.dart';

class NetworkRepository {
  final Dio _dio;
  static final _instance = NetworkRepository._();

  NetworkRepository._() : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: rootUrl,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );
  }

  factory NetworkRepository() {
    return _instance;
  }

  Future<List<DogImage>> searchImages({required int limit}) async {
    final response = await _dio.get(apiSearch,
        queryParameters: {"limit": limit},
        options: Options(headers: {
          "x-api-key": apiKey,
          "Content-Type": "application/json"
        }));
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data ?? [];
      return list
          .map((e) => DogImage.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  Future<bool> addToFavorites({required String imageId}) async {
    final response = await _dio.post(apiFavorites,
        data: {"image_id": imageId},
        options: Options(headers: {
          "x-api-key": apiKey,
          "Content-Type": "application/json"
        }));
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<bool> voteImage({required String imageId, required bool value}) async {
    final response = await _dio.post(apiVotes,
        data: {"image_id": imageId, "value": value ? 1 : 0},
        options: Options(headers: {
          "x-api-key": apiKey,
          "Content-Type": "application/json"
        }));

    return response.statusCode == 201;
  }

  Future<List<Breed>> getBreeds(
      {required int pageNumber, required int pageSize}) async {
    final response = await _dio.get(apiBreeds,
        queryParameters: {"limit": pageSize, "page": pageNumber},
        options: Options(headers: {
          "x-api-key": apiKey,
          "Content-Type": "application/json"
        }));
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data ?? [];
      return list
          .map((e) => Breed.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}
