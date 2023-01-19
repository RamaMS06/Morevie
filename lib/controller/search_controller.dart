import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:morevie/model/Search.dart';
import 'package:morevie/service/ApiClient.dart';
import 'package:morevie/service/Config.dart';

class SearchController extends GetxController {
  RxList<ListSearch?> listSearch = <ListSearch?>[].obs;
  RxString query = "".obs;
  RxBool isLoadSearch = true.obs;

  getListSearch() async {
    var getList = await ApiClient().getSearch(query.value);
    listSearch.value = getList!.listSearch!;
    isLoadSearch.value = false;
  }

  @override
  void onInit() {
    getListSearch();
    super.onInit();
  }
}
