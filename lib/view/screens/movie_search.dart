import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_route.dart';
import '../../controller/search_controller.dart';

class MovieSearch extends GetView<SearchController> {
  const MovieSearch({Key? key}) : super(key: key);
  static const route = AppRoute.search;
  static GetPage page = GetPage(
      name: MovieSearch.route,
      page: MovieSearch.new,
      preventDuplicates: true,
      binding: BindingsBuilder.put(() => SearchController()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          height: 40,
          color: Colors.transparent,
          child: TextField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              isDense: false,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              prefixIcon: const InkWell(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              hintText: 'Search Movies...',
            ),
            onChanged: (value) {
              controller.debouncer.run(() {
                controller.searchMovie(value);
              });
            },
          ),
        ),
      ),
      body: Obx(() {
        if (controller.apiResult.isEmpty) {
          return Center(
            child: Text(controller.isSearched
                ? 'Movie Not Found'
                : 'Please search movie'),
          );
        } else if (controller.isAnyError.value) {
          return Center(
            child: Text(controller.errorMessage),
          );
        }

        return ListView.builder(
            itemCount: controller.apiResult.length,
            itemBuilder: (_, index) {
              final result = controller.apiResult[index];
              bool isSearched = controller.history.contains(result);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 0.5)),
                  child: ListTile(
                    leading: Icon(isSearched ? Icons.history : Icons.search),
                    title: Text(result.title),
                    onTap: () {
                      Get.offNamed(AppRoute.detail, arguments: {
                        'movieId': result.movieId,
                        'movieTitle': result.title
                      });
                      controller.localStorage.write(result.toMap());
                    },
                  ),
                ),
              );
            });
      }),
    );
  }
}
