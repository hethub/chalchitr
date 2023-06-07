import 'package:chalchitr/app/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/constant.dart';
import '../../model/movies.dart';


class MovieListing extends StatelessWidget {
  final Results result;

  const MovieListing({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          // print(result.id);
          // print(result.title);
          Get.toNamed(AppRoute.detail,
              arguments: {'movieId': result.id!, 'movieTitle': result.title!});
        },
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage('$imageUrl${result.posterPath}'),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8))),
                  child: Text(
                    result.title ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        overflow: TextOverflow.ellipsis),
                  )),
              const Spacer(),
              Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Avg. vote : ${result.voteAverage}',
                        style: const TextStyle(
                            color: Colors.black,
                            // fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Date : ${result.releaseDate}',
                        style: const TextStyle(
                            color: Colors.black,
                            // fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
