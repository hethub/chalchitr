/// Base urls of the App
/// ===
abstract class BaseUrl {
  static const String scheme = 'https';
  static const String host = 'api.themoviedb.org';
}

/// Put all url here
///===
enum Urls implements BaseUrl {
  listing,
  detail,
  search;

  /// Parse urls and Ready to call
  /// ===
  Uri call({int? id, String? query}) {
    final queryParameters = {
      'api_key': '7d79a0348d08945377e89a95cd670c5a',
      'language': 'en-US',
      'Page': '1'
    };
    switch (this) {
      case Urls.listing:
        return Uri(
          scheme: BaseUrl.scheme,
          host: BaseUrl.host,
          path: '/3/movie/popular',
          queryParameters: queryParameters,
        );
      case Urls.detail:
        return Uri(
          scheme: BaseUrl.scheme,
          host: BaseUrl.host,
          path: '/3/movie/$id',
          queryParameters: queryParameters,
        );
      case Urls.search:
        queryParameters['query'] = query ?? '';
        return Uri(
          scheme: BaseUrl.scheme,
          host: BaseUrl.host,
          path: '/3/search/movie',
          queryParameters: queryParameters,
        );
    }
  }
}
