import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final int movieId;
  final String title;

  const SearchResult({
    required this.movieId,
    required this.title,
  });

  @override
  List<Object> get props => [movieId, title];

  factory SearchResult.fromJson(Map<String, dynamic> map) {
    return SearchResult(movieId: map['movieId'], title: map['title']);
  }

  Map<String, dynamic> toMap() {
    return {'movieId': movieId, 'title': title};
  }
}
