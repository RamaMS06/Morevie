import 'dart:math';
import 'package:get/state_manager.dart';
import 'package:morevie/model/Popular.dart';
import '../model/Trending.dart';
import '../service/ApiClient.dart';

class HomeController extends GetxController {
  RxList<Result> listResult = <Result>[].obs;
  RxBool isLoadTrending = true.obs;
  RxInt positionTrending = 0.obs;
  RxList<String>? listGenreTrending = <String>[].obs;
  RxList<String>? listGenrePopular = <String>[].obs;
  RxList<PopularResult>? listPopular = <PopularResult>[].obs;
  RxBool isLoadPopular = true.obs;
  RxInt tabIndex = 0.obs;
  RxInt idTrending = 0.obs;

  getListTrending() async {
    var getList = await ApiClient().getListTrending(1);
    listResult.value = getList!.results!;
    positionTrending.value = Random().nextInt(5);
    isLoadTrending.value = false;
    idTrending.value = getList.results![positionTrending.value].id ?? 0;
  }

  getGenresTrending() async {
    var getGenres = await ApiClient().getGenres();
    var genresTrending =
        listResult.isEmpty ? [] : listResult[positionTrending.value].genreIds;

    for (var id in genresTrending!) {
      for (var genre in getGenres.genres!) {
        if (id == genre.id) {
          if (listGenreTrending!.length >= 3) {
            listGenreTrending!.remove(listGenreTrending!.last);
          } else {
            listGenreTrending!.add(genre.name!);
          }
        }
      }
    }
  }

  getGenresPopular(int index) async {
    var getPopular = await ApiClient().getGenres();
    var genresPopular =
        listPopular!.isEmpty ? [] : listPopular![index].genreIds;

    for (var id in genresPopular!) {
      for (var genre in getPopular.genres!) {
        if (id == genre.id) {
          if (listGenrePopular!.length >= 3) {
            listGenrePopular!.remove(listGenrePopular!.last);
          } else {
            listGenrePopular!.add(genre.name!);
          }
        }
      }
    }
  }

  getPopular() async {
    var getList = await ApiClient().getPopular();
    listPopular!.value = getList.results!;
    isLoadPopular.value = false;
  }

  changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  @override
  void onInit() {
    getListTrending();
    getGenresTrending();
    getPopular();
    super.onInit();
  }
}
