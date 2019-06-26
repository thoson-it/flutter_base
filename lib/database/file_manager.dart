import 'dart:convert';
import 'dart:io';

import 'package:flutter_base/models/entity/movie_entity.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  final String _moviesFileName = "movie.txt";

  //Read data from the file
  Future<List<MovieEntity>> readMovies() async {
    try {
      final file = await _localMoviesFile;

      // Read the file.
      String contents = await file.readAsString();
      var movieMap = json.decode(contents);
      return (movieMap as List).map((json) => MovieEntity.fromJson(json))
          .toList();
    } catch (e) {
      // If encountering an error, return 0.
      return List<MovieEntity>();
    }
  }

  //Write data to the file
  Future<File> writeMovies(List<MovieEntity> movies) async {
    final file = await _localMoviesFile;
    var movieMap = movies.map((entity) => entity.toJson()).toList();
    var result = json.encode(movieMap).toString();
    // Write the file.
    return file.writeAsString('$result');
  }

  //Create a reference to the file location
  Future<File> get _localMoviesFile async {
    final path = await _localPath;
    return File('$path/$_moviesFileName}');
  }

  //Find the correct local path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
