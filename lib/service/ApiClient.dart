import 'package:morevie/model/Genres.dart';
import 'package:morevie/model/Popular.dart';
import 'package:morevie/model/Search.dart';
import 'package:morevie/model/Trending.dart';
import 'package:dio/dio.dart';
import 'package:morevie/service/Config.dart';
import 'package:morevie/service/dio/dio_client.dart';

enum ErrorResponse { success, forbidden, error }

class ApiClient extends DioClient {
  Future<Trending?> getListTrending(int page) async {
    try {
      var response = await dio.get(Config.getTrending);
      return Trending.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  Future<Genres> getGenres() async {
    try {
      var response = await dioGenres
          .get('/genre/movie/list', queryParameters: {'language': 'en-US'});
      return Genres.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Popular> getPopular() async {
    try {
      var response = await dio.get(Config.getPopular);
      return Popular.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Search?> getSearch(String query, bool isAdult, int year) async {
    try {
      var response = await dio.get(Config.getSearch, queryParameters: {
        "query": query.isEmpty ? "movie" : query,
        "include_adult": isAdult,
        "year": year
      });
      return Search.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
