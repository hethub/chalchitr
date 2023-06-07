import 'package:chalchitr/controller/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_route.dart';
import '../../constant/constant.dart';

class MovieDetailsScreen extends GetView<DetailController> {
  const MovieDetailsScreen({super.key});
  static const route = AppRoute.detail;
  static GetPage page = GetPage(
      name: MovieDetailsScreen.route,
      page: MovieDetailsScreen.new,
      preventDuplicates: true,
      binding: BindingsBuilder.put(
          () => DetailController(movieId: Get.arguments['movieId'])));

  @override
  Widget build(BuildContext context) {
    final String movieTitle = Get.arguments['movieTitle'];
    final int movieId = Get.arguments['movieId'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Movie Details'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.isTicketBooked != null) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("You Already Booked"),
                content: const Text(
                    'Are you want to again Book this movie to press yes'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: const Text("No"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(AppRoute.booking,
                          arguments: {'title': movieTitle, 'movieID': movieId});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: const Text("Yes"),
                    ),
                  ),
                ],
              ),
            );
          } else {
            Get.toNamed(AppRoute.booking,
                arguments: {'title': movieTitle, 'movieID': movieId});
          }
        },
        label: Obx(() {
          return Text(
            controller.bookTicket.value,
            style: const TextStyle(color: Colors.red),
          );
        }),
      ),
      body: Obx(() {
        return Visibility(
          visible: !controller.isLoading.value,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  alignment: AlignmentDirectional.topEnd,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: controller.detail.posterPath != null
                        ? DecorationImage(
                            image: NetworkImage(
                                '$imageUrl${controller.detail.posterPath}'),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: NetworkImage(ifImageNull),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Icon(
                    controller.isTicketBooked != null
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Colors.red,
                    size: 45,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title('Title : ', '${controller.detail.title}'),
                      const SizedBox(height: 20),
                      const Text(
                        'Overview',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${controller.detail.overview}'),
                      const SizedBox(height: 10),
                      title('Status : ', '${controller.detail.status}'),
                      title('Realesed Date : ',
                          '${controller.detail.releaseDate}'),
                      const SizedBox(height: 10),
                      title('Budget : ',
                          '\$ ${controller.detail.budget != null ? (controller.detail.budget! / 1000000).toStringAsFixed(2) : '0'} M'),
                      title('Revenue : ',
                          '\$ ${controller.detail.revenue != null ? (controller.detail.revenue! / 1000000).toStringAsFixed(2) : '0'} M'),
                      title('Total Vote : ', '${controller.detail.voteCount}'),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  RichText title(String text1, String text2) {
    return RichText(
      text: TextSpan(
        // text: 'Title : ',
        text: text1,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        children: <TextSpan>[
          TextSpan(
            text: text2,
          ),
        ],
      ),
    );
  }
}
