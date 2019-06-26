import '../base_entity.dart';

class MovieEntity extends BaseEntity {
  int id = 0;
  int voteCount = 0;
  bool video = false;
  double voteAverage = 0;
  String title = "";
  double popularity = 0.0;
  String posterPath = "";
  String originalLanguage = "";
  String originalTitle = "";
  List<int> genreIds = [];
  String backdropPath = "";
  bool adult = false;
  String overview = "";

  @override
  void parseJson(Map<String, dynamic> json) {
    id = json["id"];
    voteCount = json["vote_count"];
    video = json["video"];
    voteAverage = json["vote_average"].toDouble();
    title = json["title"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
//    genreIds = json["genre_ids"];
    backdropPath = json["backdrop_path"];
    adult = json["adult"];
    overview = json["overview"];
  }

  String getPosterPath() {
    return "https://image.tmdb.org/t/p/w185" + posterPath;
  }
}
