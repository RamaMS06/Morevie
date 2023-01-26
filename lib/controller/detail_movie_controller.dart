import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morevie/model/DetailMovie.dart';
import 'package:morevie/service/ApiClient.dart';
import 'package:get/get.dart';
import 'package:morevie/service/Config.dart';

class DetailMovieController extends GetxController {
  Rx<DetailMovie> detailMovie = DetailMovie().obs;
  RxBool isLoadingMovie = true.obs;

  getDetailMovie() async {
    var movieId = Get.arguments['movieId'];
    var data = await ApiClient().getDetailMovie(movieId);
    detailMovie.value = data!;
    isLoadingMovie.value = false;
  }

  @override
  void onInit() {
    getDetailMovie();
    super.onInit();
  }
}
