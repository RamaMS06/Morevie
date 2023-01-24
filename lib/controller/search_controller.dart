import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:morevie/model/Search.dart';
import 'package:morevie/service/ApiClient.dart';
import 'package:morevie/service/Config.dart';

class SearchController extends GetxController {
  RxList<ListSearch?> listSearch = <ListSearch?>[].obs;
  RxString query = "".obs;
  RxBool isLoadSearch = true.obs;
  RxBool isAdult = true.obs;
  RxString regions = "".obs;
  RxInt year = 2023.obs;

  getListSearch() async {
    var getList =
        await ApiClient().getSearch(query.value, isAdult.value, year.value);
    listSearch.value = getList!.listSearch!;
    isLoadSearch.value = false;
  }

  setFilterDate(DateTime date) {
    var formatDate = DateFormat('yyyy').format(date);
    year.value = int.parse(formatDate);
  }

  resetFilter() {
    regions.value = "";
    isAdult.value = false;
    year.value = 2023;
  }

  @override
  void onInit() {
    getListSearch();
    super.onInit();
  }
}
