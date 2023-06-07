import 'package:get_storage/get_storage.dart';

class LocalStorage {
  GetStorage storage = GetStorage();

  //Write in Get Storage
  void write(Map<String, dynamic> map) async {
    final history = readMovie();

    history.removeWhere((element) => element['movieId'] == map['movieId']);

    if (history.length == 5) {
      history.removeLast();
    }
    history.insert(0, map);

    await storage.write('movies', history);
  }

  List<Map<String, dynamic>> readMovie() {
    final data = storage.read('movies');
    if (data == null) {
      return [];
    }
    final List<Map<String, dynamic>> result = [];
    for (var i in data) {
      result.add(i);
    }
    // result.reversed;
    // return result.reversed.toList();
    return result;
  }

  void deleteAll() async {
    await storage.remove('movies');
  }
}
