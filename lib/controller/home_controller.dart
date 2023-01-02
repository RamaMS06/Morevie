import 'dart:math';
import 'package:get/state_manager.dart';
import 'package:morevie/model/Popular.dart';
import '../model/Trending.dart';
import '../service/ApiClient.dart';

class HomeController extends GetxController {
  RxList<Result> listResult = <Result>[].obs;
  RxBool isLoadTrending = true.obs;
  RxInt positionTrending = 0.obs;
  RxString genres = "".obs;
  RxList<String>? listGenre = <String>[].obs;
  RxList<PopularResult>? listPopular = <PopularResult>[].obs;
  RxBool isLoadPopular = true.obs;

  getListTrending() async {
    var getList = await ApiClient().getListTrending(1);
    listResult.value = getList!.results!;
    positionTrending.value = Random().nextInt(5);
    isLoadTrending.value = false;
  }

  getGenres() async {
    var getGenres = await ApiClient().getGenres();
    var genresId =
        listResult.isEmpty ? [] : listResult[positionTrending.value].genreIds;

    for (var id in genresId!) {
      for (var genre in getGenres.genres!) {
        if (id == genre.id) {
          genres.value = genre.name!;
          if (listGenre!.length >= 3) {
            listGenre!.remove(listGenre!.last);
          } else {
            listGenre!.add(genre.name!);
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

  @override
  void onInit() {
    getListTrending();
    getGenres();
    getPopular();
    super.onInit();
  }
}
