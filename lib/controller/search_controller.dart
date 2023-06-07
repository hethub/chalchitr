import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/search_result.dart';
import '../services/api/api_services.dart';
import '../services/database/get_storate_local_db.dart';

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  void run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class SearchController extends GetxController {
  final ApiServices apiServices = ApiServices();
  final Debouncer debouncer = Debouncer();
  final LocalStorage localStorage = LocalStorage();

  RxList<SearchResult> apiResult = RxList();
  RxList<SearchResult> history = RxList();

  RxBool isSearching = false.obs;
  RxBool isAnyError = false.obs;
  String errorMessage = '';
  bool isSearched = false;

  @override
  void onInit() async {
    super.onInit();
    historyFromStorage();

    // localStorage.deleteAll();
  }

  void historyFromStorage() {
    apiResult.clear();
    final oldResult = localStorage.readMovie();

    history.value = oldResult.map((e) => SearchResult.fromJson(e)).toList();

    apiResult.addAll(history);
  }

  /// Search Movie
  ///===
  Future<void> searchMovie(String query) async {
    isSearching.value = true;
    if (!isSearched) {
      isSearched = true;
    }
    Data data = await apiServices.search(query);

    if (!data.isSuccess) {
      errorMessage = data.message;
      isAnyError.value = !data.isSuccess;
      Get.snackbar('Error', errorMessage);
      isSearching.value = false;
      return;
    }

    apiResult.clear();
    for (var i in data.data) {
      apiResult.add(SearchResult(movieId: i.id!, title: i.title!));
    }
    if (query.isEmpty) {
      apiResult.addAll(history);
    }
    isSearching.value = false;
  }
}
