
import 'package:chalchitr/view/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/app_route.dart';
import '../../constant/constant.dart';
import '../../controller/home_controller.dart';
import '../widgets/movie_listing.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = AppRoute.home;
  static GetPage page = GetPage(
      name: HomeScreen.route,
      page: HomeScreen.new,
      preventDuplicates: true,
      binding: BindingsBuilder.put(() => HomeController()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.isAnyError.value) {
          return ErrorMessage(
            message: controller.errorMessage,
            isDialogueShow: true,
            func: () {
              controller.getMovieList();
            },
            funcTitle: 'Try again',
          );
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.black,
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: false,
              title: const Text(
                'CHALCHITR',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 1.1,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () async {
                      await auth.signOut();

                      Get.offAllNamed(AppRoute.login);
                    },
                    icon: const Icon(Icons.logout_rounded),
                  ),
                )
              ],
              bottom: AppBar(
                backgroundColor: Colors.black,
                title: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoute.search);
                  },
                  child: Container(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 0.5, color: Colors.white)),
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Text(
                            'Search movies',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  controller.movies.length,
                  (index) => MovieListing(
                    result: controller.movies[index],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
