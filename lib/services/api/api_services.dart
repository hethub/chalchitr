import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../model/movie_details.dart';
import '../../model/movies.dart';
import '../enum/url_enum.dart';

abstract class RequestType {
  /// GET Request
  /// ===
  Future<http.Response> getRequest(Uri uri);
}

class ApiServices extends RequestType {
  @override
  Future<http.Response> getRequest(Uri uri) async {
    return await http.get(uri);
  }

  // Get movie List
  Future<Data> movieList() async {
    try {
      final response = await http.get(Urls.listing.call());

      if (response.statusCode == 200) {
        return Data(
          data: Movies.fromJson(jsonDecode(response.body)).results ?? [],
          isSuccess: true,
          message: 'Successfull',
        );
      } else {
        return const Data(
          data: [],
          isSuccess: true,
          message: 'Some thing went wrrong!',
        );
      }
    } catch (e) {
      return Data(
        data: [],
        isSuccess: true,
        message: e.toString(),
      );
    }
  }

  Future<Data> movieDetail(int movieId) async {
    try {
      final response = await getRequest(Urls.detail.call(id: movieId));

      if (response.statusCode == 200) {
        return Data(
          data: MoviesDetails.fromJson(jsonDecode(response.body)),
          isSuccess: true,
          message: 'Successfull',
        );
      } else {
        return Data(
          data: MoviesDetails(),
          isSuccess: true,
          message: 'Some thing went wrrong!',
        );
      }
    } catch (e) {
      return Data(
        data: MoviesDetails(),
        isSuccess: false,
        message: 'Some thing went wrrong!',
      );
    }
  }

  /// Search Movie
  Future<Data> search(String query) async {
    try {
      final response = await getRequest(Urls.search.call(query: query));
      if (response.statusCode == 200) {
        return Data(
          data: Movies.fromJson(jsonDecode(response.body)).results ?? [],
          isSuccess: true,
          message: 'Successfull',
        );
      } else {
        return const Data(
          data: [],
          isSuccess: true,
          message: 'Some thing went wrrong!',
        );
      }
    } catch (e) {
      return Data(
        data: [],
        isSuccess: true,
        message: e.toString(),
      );
    }
  }
}

class Data<T> {
  final T data;
  final bool isSuccess;
  final String message;
  const Data({
    required this.data,
    required this.isSuccess,
    required this.message,
  });
}
