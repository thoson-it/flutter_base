import 'dart:convert';

import 'package:flutter_base/database/file_manager.dart';
import 'package:flutter_base/models/entity/movie_entity.dart';

class DatabaseHelper {
  //Movie
  static final String _moviesFolder = 'Movie';
  static final String _moviesFileName = '$_moviesFolder/movies.txt';

  var _fileManager = FileManager();

  ///Read data from the file
  Future<List<MovieEntity>> readMovies() async {
    try {
      // Read the file.
      String contents = await _fileManager.readFileByPath(_moviesFileName);
      var movieMap = json.decode(contents);
      return (movieMap as List)
          .map((json) => MovieEntity.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      // If encountering an error, return 0.
      return List<MovieEntity>();
    }
  }

  ///Write data to the file
  ///Return: isSuccess
  Future<bool> saveMovies(List<MovieEntity> movies) async {
    //Check folder exist
    final isExist = await _fileManager.isExitDirectory(_moviesFolder);
    if (!isExist) {
      await _fileManager.createDirectory(_moviesFolder);
    }
    //Write
    var movieMap = movies.map((entity) => entity.toJson()).toList();
    var result = json.encode(movieMap).toString();
    // Write the file.
    var file = await _fileManager.writeFileByPath(_moviesFileName, '$result');
    return file != null;
  }
}
