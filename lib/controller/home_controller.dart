import 'package:chalchitr/model/movies.dart';
import 'package:chalchitr/services/api/api_services.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiServices apiServices = ApiServices();

  final RxList<Results> _movies = RxList();

  RxList<Results> get movies => _movies;
  RxBool isLoading = false.obs;
  RxBool isAnyError = false.obs;
  RxBool isSearching = false.obs;
  String errorMessage = '';
  @override
  void onInit() async {
    super.onInit();
    getMovieList();
  }

  // Get movie List
  Future<void> getMovieList() async {
    isLoading.value = true;
    Data data = await apiServices.movieList();

    if (!data.isSuccess) {
      errorMessage = data.message;
      isAnyError.value = !data.isSuccess;
      Get.snackbar('Error', errorMessage);
      isLoading.value = false;
      return;
    }
    _movies.value = data.data;

    isLoading.value = false;
  }
}
